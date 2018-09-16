defmodule Gatehouse.CreateAdminManager do
    import Ecto.Changeset, only: [put_change: 3]
    import Ecto.Query, only: [from: 2]
    alias Gatehouse.Principal
    alias Gatehouse.Role
    alias Gatehouse.PrincipalRole
    alias Gatehouse.Repo

    def has_admin() do
        query = from p in Principal,
            preload: [:roles],
            left_join: pr in PrincipalRole, on: p.id == pr.principal_id,
            left_join: r in Role, on: r.id == pr.role_id,
            where: r.name == ^Role.admin_role
        Repo.all(query) |> length > 0
    end

    def create_principal(email, password) do
        changeset = Principal.changeset(%Principal{},
            %{email: email, password: password})
        changeset
        |> put_change(:crypted_password, Principal.pwhash(changeset.params["password"]))
        |> Repo.insert()
    end

    def create_admin(email, password) do
        role_name = Role.admin_role
        Repo.transaction(fn ->
            role = case Repo.get_by(Role, name: role_name) do
                nil ->
                    {:ok,  role} = Role.changeset(%Role{}, %{name: role_name}) |> Repo.insert()
                    role
                role -> 
                    role
            end
            {:ok, admin} = create_principal(email, password)
            role = role |> Repo.preload(:principals)
            admin = admin |> Repo.preload(:roles)
            changeset = Ecto.Changeset.change(admin) |> Ecto.Changeset.put_assoc(:roles, [role])
            Repo.update(changeset)
        end)
    end

end
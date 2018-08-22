defmodule Gatehouse.CreateAdminManager do
    import Ecto.Changeset, only: [put_change: 3]
    import Ecto.Query, only: [from: 2]
    alias Gatehouse.Principal
    alias Gatehouse.Role
    alias Gatehouse.PrincipalRole

    def has_admin(repo) do
        query = from p in Principal,
            preload: [:roles],
            left_join: pr in PrincipalRole, on: p.id == pr.principal_id,
            left_join: r in Role, on: r.id == pr.role_id,
            where: r.name == ^Role.admin_role
        repo.all(query) |> length > 0
    end

    def create_principal(repo, email, password) do
        changeset = Principal.changeset(%Principal{},
            %{email: email, password: password})
        changeset
        |> put_change(:crypted_password, hashed_password(changeset.params["password"]))
        |> repo.insert()
    end

    def create_principal(repo, email, password, role_name) do
        repo.transaction(fn ->
        role = case repo.get_by(Role, name: role_name) do
            nil ->
            {:ok,  role} = Role.changeset(%Role{}, %{name: role_name}) |> repo.insert()
            role
            role -> role
        end
        {:ok, admin} = create_principal(repo, email, password)
        role = role |> repo.preload(:principals)
        admin = admin |> repo.preload(:roles)
        changeset = Ecto.Changeset.change(admin) |> Ecto.Changeset.put_assoc(:roles, [role])
        repo.update(changeset)
        end)
    end

    defp hashed_password(password), do: Comeonin.Bcrypt.hashpwsalt(password)

end
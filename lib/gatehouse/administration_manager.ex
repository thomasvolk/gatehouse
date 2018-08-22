defmodule Gatehouse.AdministrationManager do
    import Ecto.Query, only: [from: 2]
    alias Gatehouse.Principal
    alias Gatehouse.Role
    alias Gatehouse.Repo

    def get_principal_by_id(id) do
        Repo.get_by(Principal, id: id)
    end
    
    def get_roles_with_principals() do
        query = from r in Role, preload: [:principals]
        Repo.all(query)
    end


    def get_principals() do
        Repo.all(Principal)
    end

    def update_pricipal_to_role_relation({principal_id, role_id, active}) do
        Repo.transaction(fn ->
            principal = get_principal_by_id(principal_id)
            role = Repo.get_by(Role, id: role_id)
            principal = principal |> Repo.preload(:roles)
            roles = if active do
                Enum.concat(principal.roles, [role])
            else
                Enum.filter(principal.roles, fn r -> r.id != role.id end)
            end
            changeset = Ecto.Changeset.change(principal) |> Ecto.Changeset.put_assoc(:roles, roles)
            Repo.update!(changeset)
        end)
    end

    def generate_random_password(length \\ 16), do: RandomBytes.base62(length)

end
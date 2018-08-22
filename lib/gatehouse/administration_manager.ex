defmodule Gatehouse.AdministrationManager do
    import Ecto.Changeset, only: [put_change: 3]
    import Ecto.Query, only: [from: 2]
    alias Gatehouse.Principal
    alias Gatehouse.Role
    alias Gatehouse.PrincipalRole

    def get_principal_by_id(repo, id) do
        repo.get_by(Principal, id: id)
    end
    
    def get_roles_with_principals(repo) do
        query = from r in Role, preload: [:principals]
        repo.all(query)
    end


    def get_principals(repo) do
        repo.all(Principal)
    end

    def update_pricipal_to_role_relation(repo, {principal_id, role_id, active}) do
        repo.transaction(fn ->
        principal = get_principal_by_id(repo, principal_id)
        role = repo.get_by(Role, id: role_id)
        principal = principal |> repo.preload(:roles)
        roles = if active do
            Enum.concat(principal.roles, [role])
        else
            Enum.filter(principal.roles, fn r -> r.id != role.id end)
        end
        changeset = Ecto.Changeset.change(principal) |> Ecto.Changeset.put_assoc(:roles, roles)
        repo.update!(changeset)
        end)
    end

    def generate_random_password(length \\ 16), do: RandomBytes.base62(length)

end
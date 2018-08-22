defmodule Gatehouse.SessionManager do
    import Ecto.Query, only: [from: 2]
    alias Gatehouse.Principal
    alias Gatehouse.Role
    alias Gatehouse.PrincipalRole

    def get_principal_by_email(repo, email) do
        repo.get_by(Principal, email: String.downcase(email))
    end

    def get_roles(repo) do
        repo.all(Role)
    end

    def get_roles_for_principal(repo, principal_id) do
        query = from r in Role,
            preload: [:principals],
            left_join: pr in PrincipalRole, on: r.id == pr.role_id,
            where: pr.principal_id == ^principal_id
        repo.all(query)
    end

    def get_principal_as_token_resource(repo, id) do
        principal = repo.get_by(Principal, id: id)
        role_names = get_roles_for_principal(repo, id) |> Enum.map(fn r -> r.name end)
        %{id: principal.id, email: principal.email, roles: role_names}
    end
end
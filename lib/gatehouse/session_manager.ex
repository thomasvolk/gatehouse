defmodule Gatehouse.SessionManager do
    import Ecto.Query, only: [from: 2]
    alias Gatehouse.Principal
    alias Gatehouse.Role
    alias Gatehouse.PrincipalRole
    alias Gatehouse.Repo

    def get_principal_by_email(email) do
        principal = Repo.get_by(Principal, email: String.downcase(email))
        if principal != nil do
            role_names = get_roles_for_principal(principal.id) |> Enum.map(fn r -> r.name end)
            %{
                id: principal.id, 
                crypted_password: principal.crypted_password,
                email: principal.email, 
                roles: role_names
            }
        else
            nil
        end
    end

    defp get_roles_for_principal(principal_id) do
        query = from r in Role,
            preload: [:principals],
            left_join: pr in PrincipalRole, on: r.id == pr.role_id,
            where: pr.principal_id == ^principal_id
            Repo.all(query)
    end

    def get_principal_as_token_resource(id) do
        principal = Repo.get_by(Principal, id: id)
        role_names = get_roles_for_principal(id) |> Enum.map(fn r -> r.name end)
        %{id: principal.id, email: principal.email, roles: role_names}
    end
end
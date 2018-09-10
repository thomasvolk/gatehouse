defmodule Gatehouse.AdministrationManager do
    import Ecto.Changeset, only: [put_change: 3, validate_length: 3, put_assoc: 3]
    require Logger
    alias Gatehouse.Principal
    alias Gatehouse.Role
    alias Gatehouse.Repo

    def get_principals() do
        Repo.all(Principal) |> Enum.map(fn (p) -> %{ id: p.id, email: p.email } end)
    end

    def is_admin(principal) do
        Enum.find(principal.roles, &Role.is_admin_role/1) != nil
    end

    def update_password(principal_id, password, password_repeat) do
        if password != password_repeat do
            {:error, [password: {"Passwords did not match!", []}]}    
        else
            {:ok, result} = Repo.transaction(fn ->
                principal = Repo.get_by(Principal, id: principal_id)
                case Ecto.Changeset.change(principal) 
                        |> put_change(:password, password)
                        |> validate_length(:password, min: 8)
                        |> put_change(:crypted_password, Principal.pwhash(password))
                        |> Repo.update() do
                    {:ok, _principal} -> {:ok, true}
                    {:error, %{ errors: errors }}  -> {:error, errors}      
                end
            end)
            result
        end
    end

    def update_pricipal_to_role_relation(current_principal, principal_id, role_id, active) do
        {:ok, success} = Repo.transaction(fn ->
            role = Repo.get_by(Role, id: role_id)
            if Role.is_admin_role(role.name) 
                and principal_id == current_principal.id do
                Logger.info "admin can not change his own admin privileges!"
                false
            else
                principal = Repo.get_by(Principal, id: principal_id)
                principal = principal |> Repo.preload(:roles)
                roles = if active do
                    Enum.concat(principal.roles, [role]) |> Enum.uniq
                else
                    Enum.filter(principal.roles, fn r -> r.id != role.id end)
                end
                changeset = Ecto.Changeset.change(principal) |> put_assoc(:roles, roles)
                Repo.update!(changeset)
                true
            end
        end)
        success
    end

    def get_roles() do
        Repo.all(Role) |> Enum.map(fn (r) -> %{ id: r.id, name: r.name } end)
    end


    def get_roles(:not_assigned_for_principal, principal_id) do
        all_roles = get_roles()
        principal = Repo.get_by(Principal, id: principal_id) |> Repo.preload(:roles)
        role_filter = fn(r) -> Enum.find(principal.roles , fn(pr) -> pr.id == r.id end) == nil end
        all_roles |> Enum.filter( role_filter )
    end


    def create_principal(email) do
        password = generate_random_password()
        changeset = Principal.changeset(%Principal{}, %{email: email, password: password})
        case changeset
                |> put_change(:crypted_password, Principal.pwhash(changeset.params["password"]))
                |> Repo.insert() do
            {:ok, principal} -> {:ok,  %{ id: principal.id, email: principal.email, password: password } }
            {:error, %{ errors: errors }}  -> {:error, errors}
        end    
    end

    def delete_principal(current_principal, principal_id) do
        if current_principal.id == principal_id do
            Logger.info "admin can not delete him self!"
            false
        else
            {:ok, success} = Repo.transaction(fn ->
                principal = Repo.get_by(Principal, id: principal_id)
                if principal != nil do
                    principal = principal |> Repo.preload(:roles)
                    changeset = Ecto.Changeset.change(principal) |> put_assoc(:roles, [])
                    Repo.update!(changeset)
                    {:ok, _principal} = principal 
                        |> Repo.delete
                    true
                else
                    false
                end
            end)
            success
        end
    end

    def get_principal(id) do
        principal = Repo.get_by(Principal, id: id) |> Repo.preload(:roles)
        %{ 
            id: principal.id, 
            email: principal.email,
            roles: principal.roles |> Enum.map(fn (r) -> %{id: r.id, name: r.name } end)
        }
    end

    def generate_random_password(length \\ 16), do: RandomBytes.base62(length)

end
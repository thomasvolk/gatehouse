defmodule Gatehouse.PrincipalManager do
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

  def get_role(repo, name) do
    repo.get_by(Role, name: name)
  end

  def create_role(repo, name) do
    Role.changeset(%Role{}, %{name: name}) |> repo.insert()
  end

  def link_pricipal_to_role(repo, principal, role) do
    role = role |> repo.preload(:principals)
    principal = principal |> repo.preload(:roles)
    changeset = Ecto.Changeset.change(principal) |> Ecto.Changeset.put_assoc(:roles, [role])
    repo.update(changeset)
  end

  def get_principal(repo, email) do
    repo.get_by(Principal, email: String.downcase(email))
  end

  def get_roles(repo, principal_id) do
    query = from r in Role,
      preload: [:principals],
      left_join: pr in PrincipalRole, on: r.id == pr.role_id,
      where: pr.principal_id == ^principal_id
    repo.all(query)
  end

  def get_principal_resource(repo, id) do
    principal = repo.get_by(Principal, id: id)
    role_names = get_roles(repo, id) |> Enum.map(fn r -> r.name end)
    %{id: principal.id, email: principal.email, roles: Enum.join(role_names, ",")}
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
      role = case get_role(repo, role_name) do
        nil ->
          {:ok,  role} = create_role(repo, role_name)
          role
        role -> role
      end
      {:ok, admin} = create_principal(repo, email, password)
      link_pricipal_to_role(repo, admin, role)
    end)
  end

  defp hashed_password(password), do: Comeonin.Bcrypt.hashpwsalt(password)

  def generate_random_password(length \\ 16), do: RandomBytes.base62(length)
end

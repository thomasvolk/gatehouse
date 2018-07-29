defmodule Gatehouse.PrincipalManager do
  import Ecto.Changeset, only: [put_change: 3]
  alias Gatehouse.Principal
  alias Gatehouse.Role

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

  def create_principal(repo, email, password) do
    changeset = Principal.changeset(%Principal{},
        %{email: email, password: password})
    changeset
    |> put_change(:crypted_password, hashed_password(changeset.params["password"]))
    |> repo.insert()
  end

  defp hashed_password(password), do: Comeonin.Bcrypt.hashpwsalt(password)

  def generate_random_password(length \\ 16), do: RandomBytes.base62(length)
end

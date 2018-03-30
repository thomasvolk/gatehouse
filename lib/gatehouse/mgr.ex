defmodule Gatehouse.Manager do
  import Ecto.Changeset, only: [put_change: 3]

  def register(email, password_length \\ 16) do
    password = RandomBytes.base62(password_length)
    create_principal(Gatehouse.Repo, email, password)
  end

  def create_principal(repo, email, password) do
    changeset = Gatehouse.Principal.changeset(%Gatehouse.Principal{},
        %{email: email, password: password})
    create_principal(repo, changeset)
  end

  def create_principal(repo, changeset) do
    changeset
    |> put_change(:crypted_password, hashed_password(changeset.params["password"]))
    |> repo.insert()
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end

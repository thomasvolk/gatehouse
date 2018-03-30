defmodule Gatehouse.Session do
  alias Gatehouse.Principal

  def login(repo, email, password) do
    user = repo.get_by(Principal, email: String.downcase(email))
    case authenticate(user, password) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end
end

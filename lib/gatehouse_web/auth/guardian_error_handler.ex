defmodule GatehouseWeb.GuardianErrorHandler do
  import GatehouseWeb.Router.Helpers

  def auth_error(conn, {type, _reason}, _opts) do
    redirect(conn, "an error occured: #{to_string(type)}")
  end

  def unauthenticated(conn, _params) do
    redirect(conn, "You must be signed in to access that page.")
  end

  defp redirect(conn, message) do
    conn
    |> Phoenix.Controller.put_flash(:error, message)
    |> Phoenix.Controller.redirect(to: session_path(conn, :error))
  end
end

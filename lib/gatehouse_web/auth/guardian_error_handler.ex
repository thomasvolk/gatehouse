defmodule GatehouseWeb.GuardianErrorHandler do
  import GatehouseWeb.Router.Helpers
  import GatehouseWeb.Gettext

  def auth_error(conn, {type, _reason}, _opts) do
    redirect(conn, gettext("an error occured: %{type}", type: to_string(type)))
  end

  def unauthenticated(conn, _params) do
    redirect(conn, gettext "You must be signed in to access that page.")
  end

  defp redirect(conn, message) do
    conn
    |> Phoenix.Controller.put_flash(:error, message)
    |> Phoenix.Controller.redirect(to: session_path(conn, :error))
  end
end

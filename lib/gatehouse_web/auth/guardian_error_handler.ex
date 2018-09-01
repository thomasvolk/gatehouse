defmodule GatehouseWeb.GuardianErrorHandler do
  import GatehouseWeb.Router.Helpers
  import GatehouseWeb.Gettext
  import Phoenix.Controller
  import Plug.Conn

  @api_root_path :api

  def auth_error(conn, {type, _reason}, _opts) do
    handle_error(conn, gettext("an error occured: %{type}", type: to_string(type)))
  end

  def unauthenticated(conn, _params) do
    handle_error(conn, gettext "You must be signed in to access that page.")
  end

  defp handle_error(conn, message) do
    [ root | _ ] = conn.path_info
    if root == to_string(@api_root_path) do
      send_unauthorized(conn, message)
    else
      send_redirect(conn, message)
    end
  end

  defp send_unauthorized(conn, message) do
    conn
      |> put_status(:unauthorized) 
      |> json(%{error: message})
      |> halt()
  end

  defp send_redirect(conn, message) do
    conn
      |> put_flash(:error, message)
      |> redirect(to: session_path(conn, :error))
  end
end

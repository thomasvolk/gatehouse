defmodule GatehouseWeb.GuardianErrorHandler do
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
    api_root_path = to_string(@api_root_path)
    case conn.path_info do
      [ root | _ ] when root == api_root_path -> 
          send_unauthorized(conn, message)
      _ ->
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
      |> redirect(to: "/login")
  end
end

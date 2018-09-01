defmodule GatehouseWeb.AdminAccessPlug do
  import Plug.Conn
  import Guardian.Plug
  import Phoenix.Controller
  import GatehouseWeb.Gettext
  
  def init(opts), do: opts

  def call(conn, opts) do
    principal = current_resource(conn)
    is_admin = Gatehouse.AdministrationManager.is_admin(principal)
    conn |> handle_request(is_admin, opts)
  end

  defp handle_request(conn, false, [redirect: path]) do
    conn
      |> put_flash(:error, gettext "Not allowed!")
      |> redirect(to: path)
      |> halt()
  end

  defp handle_request(conn, true, _opts), do: conn

  defp handle_request(conn, _is_admin, _opts) do
    conn
      |> put_status(:forbidden) 
      |> json(%{error: "Forbidden"})
      |> halt()
  end

end

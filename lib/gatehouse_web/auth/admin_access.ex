defmodule GatehouseWeb.AdminAccessPlug do
  import Plug.Conn
  import Guardian.Plug
  import Phoenix.Controller
  import GatehouseWeb.Gettext

  def init(opts), do: opts

  def call(conn, opts) do
    principal = current_resource(conn)
    is_admin = Gatehouse.AdministrationManager.is_admin(principal)
    case {is_admin, opts} do
      {false, [redirect: path]} -> conn
                                    |> put_flash(:error, gettext "Not allowed!")
                                    |> redirect(to: path)
                                    |> halt()
      {false, [redirect: path]} -> conn
                                    |> put_status(:forbidden) 
                                    |> json(%{error: "Forbidden"})
                                    |> halt()
      {true, _}                 -> conn
    end
  end

end

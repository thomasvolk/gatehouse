defmodule GatehouseWeb.AdminAccessPlug do
  import Plug.Conn
  import Guardian.Plug
  import Phoenix.Controller
  import GatehouseWeb.Gettext

  def init(opts), do: opts

  def call(conn, _opts) do
    principal = current_resource(conn)
    case Enum.find(principal.roles, &Gatehouse.Role.is_admin_role/1) do
      nil -> conn
          |> put_flash(:error, gettext "Not allowed!")
          |> redirect(to: "/")
          |> halt()
      _ -> conn
    end
  end

end

defmodule GatehouseWeb.AdminAccessPlug do
  import Plug.Conn
  import Guardian.Plug
  import Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    principal = current_resource(conn)
    case Enum.find(principal.roles, &(&1 == Gatehouse.Role.admin_role)) do
      nil -> conn
          |> put_flash(:error, "Not allowed!")
          |> redirect(to: "/")
          |> halt()
      _ -> conn
    end
  end

end

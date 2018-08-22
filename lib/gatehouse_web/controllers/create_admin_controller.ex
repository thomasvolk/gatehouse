defmodule GatehouseWeb.CreateAdminController do
  use GatehouseWeb, :controller
  alias Gatehouse.CreateAdminManager

  def index(conn, _params) do
    if CreateAdminManager.has_admin() do
      conn |> redirect(to: "/")
    else
      render conn, "create_admin.html"
    end
  end

  def create(conn, %{"admin" => %{"email" => email,
                                  "password" => password,
                                  "password_repeat" => password_repeat}}) do
    if not CreateAdminManager.has_admin() do
      if password != password_repeat do
        conn |> put_flash(:error, gettext("Passwords do not match!"))
             |> redirect(to: "/create_admin")
      else
        CreateAdminManager.create_admin(email, password)
      end
    end
    conn |> redirect(to: "/")
  end

end

defmodule GatehouseWeb.CreateAdminController do
  use GatehouseWeb, :controller
  alias Gatehouse.PrincipalManager
  alias Gatehouse.Repo
  alias Gatehouse.Role

  def index(conn, _params) do
    if PrincipalManager.has_admin(Gatehouse.Repo) do
      conn |> redirect(to: "/")
    else
      render conn, "create_admin.html"
    end
  end

  def create(conn, %{"admin" => %{"email" => email,
                                  "password" => password,
                                  "password_repeat" => password_repeat}}) do
    if not PrincipalManager.has_admin(Gatehouse.Repo) do
      if password != password_repeat do
        conn |> put_flash(:error, "Passwords do not match!")
             |> redirect(to: "/create_admin")
      else
        PrincipalManager.create_principal(Repo, email, password, Role.admin_role)
      end
    end
    conn |> redirect(to: "/")
  end

end

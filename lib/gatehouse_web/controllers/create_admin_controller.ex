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
        conn |> put_flash(:error, "Wrong email or password")
             |> redirect(to: "/create_admin")
      else
        Repo.transaction(fn ->
          role = case PrincipalManager.get_role(Repo, Role.admin_role) do
            nil ->
              {:ok,  role} = PrincipalManager.create_role(Repo, Role.admin_role)
              role
            role -> role
          end

          {:ok, admin} = PrincipalManager.create_principal(Repo, email, password)
          PrincipalManager.link_pricipal_to_role(Repo, admin, role)
        end)
      end
    end
    conn |> redirect(to: "/")
  end

end

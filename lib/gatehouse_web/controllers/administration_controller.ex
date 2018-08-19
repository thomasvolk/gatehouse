defmodule GatehouseWeb.AdministrationController do
  use GatehouseWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", layout: {GatehouseWeb.LayoutView, "administration.html"}
  end

  def map_principal(p) do
    %{ id: p.id, 
        email: p.email, 
        roles: Enum.map(p.roles, fn r -> %{ id: r.id, name: r.name  } end ) 
     } 
  end

  def principal_list(conn, _params) do
    principals = Gatehouse.PrincipalManager.get_principals(Gatehouse.Repo)
      |> Enum.map(fn p -> map_principal(p) end)
    json conn, principals
  end

  def principal_details(conn, %{"id" => id} = _params) do
    principal = Gatehouse.PrincipalManager.get_principal_with_roles_by_id(Gatehouse.Repo, id)
    json conn, map_principal(principal)
  end

end

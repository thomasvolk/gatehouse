defmodule GatehouseWeb.AdministrationController do
  use GatehouseWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", layout: {GatehouseWeb.LayoutView, "administration.html"}
  end

  defp map_principal(p) do
    %{ id: p.id, 
        email: p.email, 
        roles: Enum.map(p.roles, fn r -> %{ id: r.id, name: r.name  } end ) 
     } 
  end

  def principal_list(conn, _params) do
    principals = Gatehouse.PrincipalManager.get_principals(Gatehouse.Repo)
      |> Enum.map(&map_principal/1)
    json conn, principals
  end

  def principal_details(conn, %{"id" => id} = _params) do
    principal = Gatehouse.PrincipalManager.get_principal_with_roles_by_id(Gatehouse.Repo, id)
    json conn, map_principal(principal)
  end

  def role_list(conn, %{"markForPrincipalId" => markForPrincipalId} = _params) do
    pid = String.to_integer(markForPrincipalId)
    roles = Gatehouse.PrincipalManager.get_roles_with_principals(Gatehouse.Repo)
      |> Enum.map(fn r -> %{id: r.id, 
                            name: r.name, 
                            active: r.principals |> Enum.count(fn p -> p.id == pid end) > 0 } 
                  end)
    json conn, roles
  end

  def role_list(conn, _params) do
    roles = Gatehouse.PrincipalManager.get_roles(Gatehouse.Repo)
      |> Enum.map(fn r -> %{id: r.id, name: r.name} end)
    json conn, roles
  end

end

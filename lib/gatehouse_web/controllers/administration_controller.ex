defmodule GatehouseWeb.AdministrationController do
  use GatehouseWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", layout: {GatehouseWeb.LayoutView, "administration.html"}
  end

  defp map_principal(p) do
    %{ id: p.id, 
        email: p.email
     } 
  end

  def principal_list(conn, _params) do
    principals = Gatehouse.PrincipalManager.get_principals(Gatehouse.Repo)
      |> Enum.map(&map_principal/1)
    json conn, principals
  end

  def principal_details(conn, %{"id" => id} = _params) do
    principal = map_principal(Gatehouse.PrincipalManager.get_principal_by_id(Gatehouse.Repo, id))
    roles = Gatehouse.PrincipalManager.get_roles_with_principals(Gatehouse.Repo)
                |> Enum.map(fn r -> %{id: r.id, 
                          name: r.name, 
                          active: r.principals |> Enum.count(fn p -> p.id == String.to_integer(id) end) > 0 } 
                end)
    json conn, Map.put(principal, :roles, roles) 
  end

end

defmodule GatehouseWeb.AdministrationController do
  use GatehouseWeb, :controller
  alias Gatehouse.AdministrationManager

  def index(conn, _params) do
    render conn, "index.html", layout: {GatehouseWeb.LayoutView, "administration.html"}
  end

  defp map_principal(p) do
    %{ id: p.id, 
        email: p.email
     } 
  end

  def principal_list(conn, _params) do
    principals = AdministrationManager.get_principals()
      |> Enum.map(&map_principal/1)
    json conn, principals
  end

  def principal_details(conn, %{"id" => id} = _params) do
    principal = map_principal(AdministrationManager.get_principal_by_id(id))
    roles = AdministrationManager.get_roles_with_principals()
                |> Enum.map(fn r -> %{id: r.id, 
                          name: r.name, 
                          active: r.principals |> Enum.count(fn p -> p.id == String.to_integer(id) end) > 0 } 
                end)
    json conn, Map.put(principal, :roles, roles) 
  end

  def update_role_relation(conn, %{"principal_id" => principal_id, "role_id" => role_id, "active" => active}) do
    AdministrationManager.update_pricipal_to_role_relation(
       {principal_id, role_id, active})
       json conn, "OK" 
  end

end

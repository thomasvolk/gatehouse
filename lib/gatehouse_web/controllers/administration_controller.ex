defmodule GatehouseWeb.AdministrationController do
  use GatehouseWeb, :controller
  alias Gatehouse.AdministrationManager

  def index(conn, _params) do
    render conn, "index.html", layout: {GatehouseWeb.LayoutView, "administration.html"}
  end

  def principal_list(conn, _params) do
    principals = AdministrationManager.get_principals()
    json conn, principals
  end

  def principal_with_roles_selection_list(conn, %{"id" => id} = _params) do
    principal = AdministrationManager.principal_with_roles_selection_list(id)
    json conn, principal
  end

  def update_role_relation(conn, %{"principal_id" => principal_id, 
                                 "role_id" => role_id, "active" => active}) do
    currnet_principal = Gatehouse.Guardian.Plug.current_resource(conn)        
    AdministrationManager.update_pricipal_to_role_relation(
      currnet_principal, principal_id, role_id, active)
    json conn, true
  end
  
end

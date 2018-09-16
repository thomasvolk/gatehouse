defmodule GatehouseWeb.AdministrationController do
  use GatehouseWeb, :controller
  import GatehouseWeb.ApiResultHandler
  alias Gatehouse.AdministrationManager

  def index(conn, _params) do
    render conn, "index.html", layout: {GatehouseWeb.LayoutView, "administration.html"}
  end

  def get_principals(conn, _params) do
    conn |> handle_result(AdministrationManager.get_principals())
  end

  def get_principal(conn, %{"principal_id" => principal_id} = _params) do
    conn |> handle_result(AdministrationManager.get_principal(principal_id))
  end

  def update_role_relation(conn, %{"principal_id" => principal_id, 
                                 "role_id" => role_id, "active" => active}) do
    currnet_principal = Gatehouse.Guardian.Plug.current_resource(conn)        
    success = AdministrationManager.update_pricipal_to_role_relation(
      currnet_principal, String.to_integer(principal_id), role_id, active)
    conn |> handle_result(success)
  end

  def update_password(conn, %{"principal_id" => principal_id, 
                              "password" => password,
                              "passwordRepeat" => password_repeat}) do
    conn |> handle_result(AdministrationManager.update_password(principal_id, password, password_repeat))
  end

  def create_principal(conn, %{"email" => email}) do
    conn |> handle_result(AdministrationManager.create_principal(email))
  end

  def delete_principal(conn, %{"principal_id" => principal_id}) do
    currnet_principal = Gatehouse.Guardian.Plug.current_resource(conn)  
    success = AdministrationManager.delete_principal(currnet_principal, 
                String.to_integer(principal_id))
    conn |> handle_result(success)
  end

  def get_roles(conn, %{"notAssignedForPrincipal" => principal_id}) do
    id = String.to_integer(principal_id)
    conn |> handle_result(AdministrationManager.get_roles(:not_assigned_for_principal, id))
  end

  def get_roles(conn, _params) do
    conn |> handle_result(AdministrationManager.get_roles())
  end

  def get_role(conn, %{"role_id" => role_id}) do
    conn |> handle_result(AdministrationManager.get_role(String.to_integer(role_id)))
  end

  def create_role(conn, %{"name" => name}) do
    conn |> handle_result(AdministrationManager.create_role(name))
  end
  
  def delete_role(conn, %{"role_id" => role_id}) do
    conn |> handle_result(AdministrationManager.delete_role(String.to_integer(role_id)))
  end
end

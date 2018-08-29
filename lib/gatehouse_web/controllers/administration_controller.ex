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
    success = AdministrationManager.update_pricipal_to_role_relation(
      currnet_principal, String.to_integer(principal_id), role_id, active)
    json conn, success
  end

  def update_password(conn, %{"principal_id" => principal_id, 
                              "password" => password}) do
    case AdministrationManager.update_password(principal_id, password) do
      {:ok, success} -> json conn, success
      {:error, errors} -> handle_error(conn, errors)
    end
  end

  def create_principal(conn, %{"email" => email}) do
    case AdministrationManager.create_principal(email) do
      {:ok, principal} -> json conn, principal
      {:error, errors} -> handle_error(conn, errors)
    end
  end

  defp handle_error(conn, [email: {msg, _values}]) do
    conn |> send_resp(400, msg)
  end

  defp handle_error(conn, [password: {msg, _values}]) do
    conn |> send_resp(400, msg)
  end

  defp handle_error(conn, _errors) do
    conn |> send_resp(500, "unkonwn")
  end
  
end

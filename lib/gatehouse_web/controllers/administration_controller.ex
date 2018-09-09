defmodule GatehouseWeb.AdministrationController do
  use GatehouseWeb, :controller
  alias Gatehouse.AdministrationManager

  def index(conn, _params) do
    render conn, "index.html", layout: {GatehouseWeb.LayoutView, "administration.html"}
  end

  def get_principals(conn, _params) do
    principals = AdministrationManager.get_principals()
    json conn, principals
  end

  def get_principal(conn, %{"principal_id" => principal_id} = _params) do
    principal = AdministrationManager.get_principal(principal_id)
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

  def delete_principal(conn, %{"principal_id" => principal_id}) do
    currnet_principal = Gatehouse.Guardian.Plug.current_resource(conn)  
    success = AdministrationManager.delete_principal(currnet_principal, 
                String.to_integer(principal_id))
    json conn, success
  end

  def get_roles(conn, _params) do
    json conn, AdministrationManager.get_roles()
  end

  defp handle_error(conn, [email: {msg, _values}]) do
    conn |> put_status(:bad_request) |> json(%{error: msg})
  end

  defp handle_error(conn, [password: {msg, _values}]) do
    conn |> put_status(:bad_request) |> json(%{error: msg})
  end

  defp handle_error(conn, _errors) do
    conn |> put_status(:internal_server_error) |> json(%{error: "unknown error"})
  end
  
end

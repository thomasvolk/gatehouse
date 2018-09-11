defmodule Gatehouse.CurrentSession do
  import Plug.Conn
  import Guardian.Plug

  def init(opts), do: opts

  def call(conn, _opts) do
    principal = current_resource(conn)
    {:ok, token, _claims} = Gatehouse.Guardian.encode_and_sign(principal)
    conn |> assign(:session, %{ principal: principal, token: token })
  end

  def token(conn) do
    principal = current_resource(conn)
    {:ok, token, _claims} = Gatehouse.Guardian.encode_and_sign(principal)
    token
  end

  def current_user(conn) do
    Gatehouse.Guardian.Plug.current_resource(conn)
  end

  def is_admin?(conn) do
    if logged_in?(conn) do
      principal = current_resource(conn)
      Gatehouse.AdministrationManager.is_admin(principal)      
    end
  end

  def logged_in?(conn), do: !!current_user(conn)
end

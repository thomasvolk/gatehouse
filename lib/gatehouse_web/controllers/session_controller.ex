defmodule GatehouseWeb.SessionController do
  use GatehouseWeb, :controller
  alias Gatehouse.Target
  alias Gatehouse.CreateAdminManager
  alias Gatehouse.AdministrationManager
  alias Gatehouse.Session

  def index(conn, %{ "target" => target }) do
    if CreateAdminManager.has_admin() do
      render conn, "index.html", target: target
    else
      conn |> redirect(to: "/create_admin")
    end
  end

  def index(conn, params) do
    index conn, Map.put(params, "target", "/session" )
  end

  def session(conn, %{ "access_token" => token }) do
    {:ok, claims} = Gatehouse.Guardian.decode_and_verify(token)
    currnet_principal = Gatehouse.Guardian.Plug.current_resource(conn)  
    render conn, "session_with_token.html", claims: inspect(claims), is_admin: AdministrationManager.is_admin(currnet_principal)
  end

  def session(conn, _params) do
    currnet_principal = Gatehouse.Guardian.Plug.current_resource(conn)  
    render conn, "session.html", is_admin: AdministrationManager.is_admin(currnet_principal)
  end

  def goto(conn, %{"target" => target}) do
    token = Gatehouse.CurrentSession.token(conn)
    redirect(conn, external:  Target.add_access_token_to_uri(target, token))
  end

  def create(conn, %{"session" => %{"email" => email,
                                  "password" => password,
                                  "target" => target}}) do
    case Session.login(email, password) do
      {:ok, user} ->
        conn
        |> Gatehouse.Guardian.Plug.sign_in(user)
        |> put_flash(:info, gettext("Logged in"))
        |> redirect(to: "/goto?target=#{target}")
      :error ->
        conn
        |> put_flash(:error, gettext("Wrong email or password"))
        |> redirect(to: "/")
    end
  end

  def delete(conn, _) do
    conn
    |> Gatehouse.Guardian.Plug.sign_out()
    |> put_flash(:info, gettext("Logged out"))
    |> redirect(to: "/")
  end

  def error(conn, params) do
    index conn, params
  end

end

defmodule GatehouseWeb.AdministrationController do
  use GatehouseWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", layout: {GatehouseWeb.LayoutView, "administration.html"}
  end

  def principal(conn, _params) do
    principals = Gatehouse.PrincipalManager.get_principals(Gatehouse.Repo)
      |> Enum.map(fn p -> 
                        %{ id: p.id, 
                          email: p.email, 
                          roles: Enum.map(p.roles, fn r -> %{ id: r.id, name: r.name  } end ) 
                        } 
                  end)
    json conn, principals
  end

end

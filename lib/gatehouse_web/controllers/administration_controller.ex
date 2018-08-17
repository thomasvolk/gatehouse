defmodule GatehouseWeb.AdministrationController do
  use GatehouseWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", layout: {GatehouseWeb.LayoutView, "administration.html"}
  end

  def principal_list(conn, _params) do
    principals = Gatehouse.PrincipalManager.get_principals(Gatehouse.Repo)
      |> Enum.map(fn p -> 
                        %{ id: p.id, 
                          email: p.email, 
                          roles: Enum.map(p.roles, fn r -> %{ id: r.id, name: r.name  } end ) 
                        } 
                  end)
    json conn, principals
  end

  def principal_details(conn, %{"id" => id} = params) do
    json conn, Gatehouse.PrincipalManager.get_principal_resource(Gatehouse.Repo, id)
  end

end

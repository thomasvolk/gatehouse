defmodule GatehouseWeb.AdministrationController do
  use GatehouseWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", layout: {GatehouseWeb.LayoutView, "administration.html"}
  end

end

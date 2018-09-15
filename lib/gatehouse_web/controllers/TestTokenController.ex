defmodule GatehouseWeb.TestTokenController do
    use GatehouseWeb, :controller

    def index(conn, _params) do
        token = Guardian.Plug.current_claims(conn, [])
        json conn, token
    end
end
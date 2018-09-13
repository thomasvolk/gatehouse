defmodule GatehouseWeb.TestTokenController do
    use GatehouseWeb, :controller

    def index(conn, _params) do
        json conn, %{success: true}
    end
end
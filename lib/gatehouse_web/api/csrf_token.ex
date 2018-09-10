defmodule GatehouseWeb.CSRFToken do
  import Plug.Conn
  import Guardian.Plug

  def init(opts), do: opts

  def call(conn, _opts) do
    token = Plug.CSRFProtection.get_csrf_token()
    conn |> put_resp_header("x-csrf-token", token)
  end

end

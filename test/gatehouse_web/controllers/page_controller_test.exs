defmodule GatehouseWeb.PageControllerTest do
  use GatehouseWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Gatehouse"
  end
end

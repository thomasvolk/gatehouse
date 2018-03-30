defmodule GatehouseWeb.ErrorViewTest do
  use GatehouseWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(GatehouseWeb.ErrorView, "404.html", []) =~
           "404: Sorry resource not found!"
  end

  test "render 500.html" do
    assert render_to_string(GatehouseWeb.ErrorView, "500.html", []) =~
           "Sorry an error occured!"
  end

  test "render any other" do
    assert render_to_string(GatehouseWeb.ErrorView, "505.html", []) =~
           "Sorry an error occured!"
  end
end

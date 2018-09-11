defmodule GatehouseWeb.LayoutView do
  use GatehouseWeb, :view
  import Gatehouse.CurrentSession, only: [current_user: 1, logged_in?: 1, is_admin?: 1]

end

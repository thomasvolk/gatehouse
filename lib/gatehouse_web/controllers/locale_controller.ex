defmodule GatehouseWeb.LocaleController do
    use GatehouseWeb, :controller

    def get_translation(conn, %{ "language" => _language }) do
        translation = %{
            principals: gettext("Principals"),
            create_principal: gettext("Create Principal"),
            roles: gettext("Roles"),
            create_role: gettext("Create Role")
        }
        json conn, translation
    end
end
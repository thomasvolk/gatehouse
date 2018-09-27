defmodule GatehouseWeb.LocaleController do
    use GatehouseWeb, :controller

    def get_translation(conn, %{ "language" => _language }) do
        translation = %{
            principals: gettext("Principals"),
            create_principal: gettext("Create Principal"),
            roles: gettext("Roles"),
            create_role: gettext("Create Role"),
            cancel: gettext("Cancel"),
            close: gettext("Close"),
            create: gettext("Create"),
            yes_delete: gettext("Yes Delete"),
            delete_principal: gettext("Delete Principal"),
            change_password: gettext("Change Password"),
            hide_password: gettext("Hide password"),
            show_password: gettext("Show password"),
            delete_role: gettext("Delete Role"),
            password: gettext("Password"),
            password_repeat: gettext("Password Repeat"),
            password_successfully_changed: gettext("Password successfully changed")
        }
        json conn, translation
    end
end
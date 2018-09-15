defmodule GatehouseWeb.Guardian.ErrorHandler do
  defmacro __using__(_opts) do
    quote do
      import GatehouseWeb.Gettext
      import Phoenix.Controller
      import Plug.Conn

      def auth_error(conn, {type, _reason}, _opts) do
        handle_error(conn, gettext("an error occured: %{type}", type: to_string(type)))
      end
    
      def unauthenticated(conn, _params) do
        handle_error(conn, gettext "You must be signed in to access that page.")
      end
    end
  end
end

defmodule GatehouseWeb.Guardian.RedirectErrorHandler do
  use GatehouseWeb.Guardian.ErrorHandler

  defp handle_error(conn, message) do
    parameter = case conn.query_string do
      "" -> ""
      query -> "?#{query}"
    end
    conn
      |> redirect(to: "/login#{parameter}"  )
  end
end

defmodule GatehouseWeb.Guardian.ApiErrorHandler do
  use GatehouseWeb.Guardian.ErrorHandler

  defp handle_error(conn, message) do
    conn
      |> put_status(:unauthorized) 
      |> json(%{error: message})
      |> halt()
  end
end
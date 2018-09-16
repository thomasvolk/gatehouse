defmodule GatehouseWeb.ApiErrorHandler do
    import Phoenix.Controller
    import Plug.Conn

    def handle_error(conn, [email: {msg, _values}]) do
        conn |> put_status(:bad_request) |> json(%{error: msg})
    end

    def handle_error(conn, [password: {_msg, [count: _count, validation: :length, min: min_count]}]) do
        conn |> put_status(:bad_request) |> json(%{error: "should be at least #{min_count} character(s)"})
    end

    def handle_error(conn, [password: {msg, _values}]) do
        conn |> put_status(:bad_request) |> json(%{error: msg})
    end

    def handle_error(conn, _errors) do
        conn |> put_status(:internal_server_error) |> json(%{error: "unknown error"})
    end
end
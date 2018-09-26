defmodule GatehouseWeb.ApiResultHandler do
    import Phoenix.Controller
    import Plug.Conn
    import GatehouseWeb.Gettext

    def handle_result(conn, result) do
        case result do
            {:ok, data} -> json conn, data
            {:error, errors} -> handle_error(conn, errors)
            _ -> json conn, result
        end
    end

    defp handle_error(conn, [email: {msg, _values}]) do
        conn |> put_status(:bad_request) |> json(%{error: msg})
    end

    defp handle_error(conn, [password: {_msg, [count: _count, validation: :length, min: min_count]}]) do
        message = gettext("should be at least %{min_count} character(s)", min_count: to_string(min_count))
        conn |> put_status(:bad_request) 
             |> json(%{error: message})
    end

    defp handle_error(conn, [password: {msg, _values}]) do
        conn |> put_status(:bad_request) |> json(%{error: msg})
    end

    defp handle_error(conn, _errors) do
        conn |> put_status(:internal_server_error) |> json(%{error: gettext("unknown error")})
    end
end
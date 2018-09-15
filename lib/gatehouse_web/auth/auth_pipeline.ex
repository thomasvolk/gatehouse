defmodule GatehouseWeb.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :gatehouse

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug Gatehouse.CurrentSession
end

defmodule GatehouseWeb.ApiAuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :gatehouse

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug Gatehouse.CurrentSession
end

defmodule GatehouseWeb.TestApiAuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :gatehouse

  plug Guardian.Plug.VerifyHeader, module: Gatehouse.Guardian, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated, module: Gatehouse.Guardian

end

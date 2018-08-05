defmodule GatehouseWeb.Router do
  use GatehouseWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :login_required do
    plug Gatehouse.AuthAccessPipeline
    plug Gatehouse.CurrentSession
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GatehouseWeb do
    pipe_through [:browser]

    get    "/",              SessionController, :index
    get    "/create_admin",  CreateAdminController, :index
    post   "/create_admin",  CreateAdminController, :create
    get    "/error",         SessionController, :error
    post   "/login",         SessionController, :create

    scope "/" do
      pipe_through [:login_required]

      get    "/goto",     SessionController, :goto
      get    "/session",  SessionController, :session
      delete "/logout",   SessionController, :delete

      get    "/administration", AdministrationController, :index
    end

  end

end

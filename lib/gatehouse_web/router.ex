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

  pipeline :administration do
    plug GatehouseWeb.AdminAccessPlug, redirect: "/login"
    plug GatehouseWeb.CSRFToken
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Gatehouse.AuthAccessPipeline
    plug Gatehouse.CurrentSession
    plug GatehouseWeb.AdminAccessPlug
    plug GatehouseWeb.CSRFToken
  end

  scope "/", GatehouseWeb do
    pipe_through [:browser]

    get    "/login",         SessionController, :login
    get    "/create_admin",  CreateAdminController, :index
    post   "/create_admin",  CreateAdminController, :create
    post   "/login",         SessionController, :create

    scope "/" do
      pipe_through [:login_required]

      get    "/",         SessionController, :index
      get    "/goto",     SessionController, :goto
      delete "/logout",   SessionController, :delete
      get    "/logout",   SessionController, :delete

      scope "/administration" do
        pipe_through [:administration]
        get    "/",           AdministrationController, :index
      end

    end

  end

  scope "/api", GatehouseWeb do
    pipe_through [:api]
    get    "/principal",      AdministrationController, :get_principals
    get    "/principal/:principal_id",  AdministrationController, :get_principal
    put    "/principal/:principal_id/role/:role_id",  AdministrationController, :update_role_relation
    put    "/principal/:principal_id/password", AdministrationController, :update_password
    post   "/principal", AdministrationController, :create_principal
    delete "/principal/:principal_id", AdministrationController, :delete_principal
    get    "/role", AdministrationController, :get_roles
  end

end

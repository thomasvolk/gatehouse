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

  pipeline :admin_role do
    plug GatehouseWeb.AdminAccessPlug
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
      get    "/logout",   SessionController, :delete

      scope "/administration" do
        pipe_through [:admin_role]
        get    "/",           AdministrationController, :index
        
        scope "/api" do
          get    "/principal",      AdministrationController, :principal_list
          get    "/principal/:id/roles_selection_list",  AdministrationController, :principal_with_roles_selection_list
          put    "/principal/:principal_id/role/:role_id",  AdministrationController, :update_role_relation
        end

      end

    end

  end

end

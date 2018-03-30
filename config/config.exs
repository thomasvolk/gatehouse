# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gatehouse,
  ecto_repos: [Gatehouse.Repo]

# Configures the endpoint
config :gatehouse, GatehouseWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: GatehouseWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Gatehouse.PubSub,
           adapter: Phoenix.PubSub.PG2],
  server: if System.get_env("SERVER") == "off", do: false, else: true

config :gatehouse, Gatehouse.AuthAccessPipeline,
  module: Gatehouse.Guardian,
  error_handler: GatehouseWeb.GuardianErrorHandler

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

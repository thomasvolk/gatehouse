use Mix.Config

config :gatehouse, GatehouseWeb.Endpoint,
  load_from_system_env: true,
  root: "."

# Do not print debug messages in production
config :logger, level: :info

# cookies
config :gatehouse, GatehouseWeb.Endpoint,
  secret_key_base: "..............................."

# database
config :gatehouse, Gatehouse.Repo,
  adapter: Ecto.Adapters.MySQL,
  pool_size:  10

# authentication
config :gatehouse, Gatehouse.Guardian,
  issuer:     "Gatehouse"

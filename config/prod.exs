use Mix.Config

config :gatehouse, GatehouseWeb.Endpoint,
  load_from_system_env: true,
  root: "."

# Do not print debug messages in production
config :logger, level: :info


# Finally import the config/prod.secret.exs
# which should be versioned separately.
import_config "prod.secret.exs"

# prod.secret.exs

#
# config :gatehouse, Gatehouse.Repo,
#  adapter: Ecto.Adapters.MySQL,
#   username: __YOUR_DB_USER__,
#   password: __YOUR_DB_USER_PWD__,
#   database: __YOUR_DB_NAME__,
#   hostname: __YOUR_DB_HOST__,
#   pool_size: 10,
#   port: 13306
#
# config :gatehouse, Gatehouse.Guardian,
#   issuer: "Gatehouse.#{Mix.env}",
#   secret_key: to_string(Mix.env) <> __YOUR_SECRET__,
#   ttl: {1, :hour}
#

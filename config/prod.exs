use Mix.Config

config :gatehouse, GatehouseWeb.Endpoint,
  load_from_system_env: true,
  root: "."

# Do not print debug messages in production
config :logger, level: :info

# cookies
config :gatehouse, GatehouseWeb.Endpoint,
  secret_key_base: {:system, "GATEHOUSE_WEB_SECRET_KEY_BASE"}

# database
config :gatehouse, Gatehouse.Repo,
  adapter: Ecto.Adapters.MySQL,
  username:   {:system, "GATEHOUSE_DB_USER"},
  password:   {:system, "GATEHOUSE_DB_PASSWORD"},
  database:   {:system, "GATEHOUSE_DB_NAME"},
  pool_size:  {:system, "GATEHOUSE_DB_POOL_SIZE"},
  hostname:   {:system, "GATEHOUSE_DB_HOST"},
  port:       {:system, "GATEHOUSE_DB_PORT"}

# authentication
config :gatehouse, Gatehouse.Guardian,
  issuer:     {:system, "GATEHOUSE_AUTH_ISSUER"},
  secret_key: {:system, "GATEHOUSE_AUTH_SECRET_KEY"},
  ttl:       {{:system, "GATEHOUSE_AUTH_TOKEN_TTL"}, :seconds}

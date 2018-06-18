use Mix.Config

config :gatehouse, GatehouseWeb.Endpoint,
  load_from_system_env: true,
  root: "."

# Do not print debug messages in production
config :logger, level: :info

# cookies
config :gatehouse, GatehouseWeb.Endpoint,
  secret_key_base: "${GATEHOUSE_WEB_SECRET_KEY_BASE}"

# database
config :gatehouse, Gatehouse.Repo,
  adapter: Ecto.Adapters.MySQL,
  username:   "${GATEHOUSE_DB_USER}",
  password:   "${GATEHOUSE_DB_PASSWORD}",
  database:   "${GATEHOUSE_DB_NAME}",
  hostname:   "${GATEHOUSE_DB_HOST}",
  port:       "${GATEHOUSE_DB_PORT}",
  pool_size:  10

# authentication
config :gatehouse, Gatehouse.Guardian,
  issuer:     "Gatehouse",
  secret_key: "${GATEHOUSE_AUTH_SECRET_KEY}",
  ttl:       {"${GATEHOUSE_AUTH_TOKEN_TTL}", :seconds}

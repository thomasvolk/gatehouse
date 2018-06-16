use Mix.Config

config :gatehouse, GatehouseWeb.Endpoint,
  load_from_system_env: true,
  root: "."

# Do not print debug messages in production
config :logger, level: :info

# cookies
config :gatehouse, GatehouseWeb.Endpoint,
  secret_key_base: System.get_env("GATEHOUSE_WEB_SECRET_KEY_BASE")

# database
config :gatehouse, Gatehouse.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: System.get_env("GATEHOUSE_DB_USER_NAME") || "gatehouse",
  password: System.get_env("GATEHOUSE_DB_PASSWORD"),
  database: System.get_env("GATEHOUSE_DB_NAME") || "gatehouse",
  pool_size: String.to_integer(System.get_env("GATEHOUSE_DB_POOL_SIZE") || "10"),
  hostname: System.get_env("GATEHOUSE_DB_HOST") || "localhost",
  port: String.to_integer(System.get_env("GATEHOUSE_DB_PORT") || "3306")

# authentication
config :gatehouse, Gatehouse.Guardian,
  issuer: System.get_env("GATEHOUSE_AUTH_ISSUER") || "Gatehouse",
  secret_key: System.get_env("GATEHOUSE_AUTH_SECRET_KEY"),
  ttl: {String.to_integer(System.get_env("GATEHOUSE_AUTH_TOKEN_TTL") || "3600"), :seconds}

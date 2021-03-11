import Config

config :gatehouse, Gatehouse.Repo,
  adapter: Ecto.Adapters.MySQL,
  username:   System.fetch_env!("GATEHOUSE_DB_USER"),
  password:   System.fetch_env!("GATEHOUSE_DB_PASSWORD"),
  database:   System.fetch_env!("GATEHOUSE_DB_NAME"),
  hostname:   System.fetch_env!("GATEHOUSE_DB_HOST"),
  port:       String.to_integer(System.fetch_env!("GATEHOUSE_DB_PORT")),
  pool_size:  10

config :gatehouse, Gatehouse.Guardian,
  issuer:     "Gatehouse",
  secret_key: System.fetch_env!("GATEHOUSE_AUTH_SECRET_KEY"),
  ttl:        {String.to_integer(System.fetch_env!("GATEHOUSE_AUTH_TOKEN_TTL")), :seconds}

config :gatehouse, GatehouseWeb.Endpoint,
  secret_key_base: System.fetch_env!("GATEHOUSE_WEB_SECRET_KEY_BASE")
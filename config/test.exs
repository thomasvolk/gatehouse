use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gatehouse, GatehouseWeb.Endpoint,
  secret_key_base: "Dn0MUHCWLaC1zC6JnAWqZrl5hs2M71f8F6PxXTPfJXAc8Lv82OYcV/uwuB42YA9K",
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :phoenix, :stacktrace_depth, 20

# Configure your database
config :gatehouse, Gatehouse.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "gatehouse",
  password: "gatehouse",
  database: "gatehouse",
  hostname: "localhost",
  pool_size: 10,
  pool: Ecto.Adapters.SQL.Sandbox,
  port: 13306

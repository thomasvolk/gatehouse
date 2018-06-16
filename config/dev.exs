use Mix.Config

# USE THIS CONFIGURATION FOR TESTION ONLY!
# to run the service you have to use the prod configuration
# and add your own secret_key in

config :gatehouse, Gatehouse.Guardian,
  issuer: "Gatehouse.#{Mix.env}",
  secret_key: to_string(Mix.env) <> "_A1yzSKfmfiQgwZ08vIeuXUQqkG8",
  ttl: {10, :minute}

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :gatehouse, GatehouseWeb.Endpoint,
  secret_key_base: "Dn0MUHCWLaC1zC6JnAWqZrl5hs2M71f8F6PxXTPfJXAc8Lv82OYcV/uwuB42YA9K",
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../assets", __DIR__)]]


# Watch static and templates for browser reloading.
config :gatehouse, GatehouseWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/gatehouse_web/views/.*(ex)$},
      ~r{lib/gatehouse_web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :gatehouse, Gatehouse.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "gatehouse",
  password: "gatehouse",
  database: "gatehouse",
  hostname: "localhost",
  pool_size: 10,
  port: 13306

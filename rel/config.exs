# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,

default_release: :default,
default_environment: :default

environment :default do
  set dev_mode: false
  set include_erts: true
  set include_src: false
  set cookie: :base64.encode(:crypto.strong_rand_bytes(128))
end

release :gatehouse do
  set version: current_version(:gatehouse)
  set applications: [
    :runtime_tools
  ]
end

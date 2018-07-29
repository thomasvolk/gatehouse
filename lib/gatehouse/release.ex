defmodule Gatehouse.Release.Tasks do
  def migrate do
    {:ok, _} = Application.ensure_all_started(:gatehouse)

    path = Application.app_dir(:gatehouse, "priv/repo/migrations")

    Ecto.Migrator.run(Gatehouse.Repo, path, :up, all: true)
  end
end

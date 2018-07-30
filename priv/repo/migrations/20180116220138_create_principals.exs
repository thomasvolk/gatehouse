defmodule Gatehouse.Repo.Migrations.CreatePricipals do
  use Ecto.Migration

  def change do
    create table(:principals) do
      add :email, :string
      add :crypted_password, :string
      timestamps()
    end
    create unique_index(:principals, [:email])
  end
end

defmodule Gatehouse.Repo.Migrations.CreatePrincipalsToRoles do
  use Ecto.Migration

  def change do
    create table(:principals_to_roles) do
        add :principal_id, references(:principals)
        add :role_id, references(:roles)
      end
      create unique_index(:principals_to_roles, [:principal_id, :role_id])
  end
end

defmodule Gatehouse.PrincipalRole do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gatehouse.Role
  alias Gatehouse.Principal

  schema "principals_to_roles" do
    belongs_to :principal, Principal
    belongs_to :role, Role
  end

  @required_fields ~w(principal, role)
  @optional_fields ~w()

  @doc false
  def changeset(%Role{} = role, attrs) do
    role
      |> cast(attrs, @required_fields, @optional_fields)
      |> unique_constraint(:principal, :role)
  end
end

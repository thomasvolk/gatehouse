defmodule Gatehouse.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gatehouse.Role

  @admin :GatehouseAdmin

  schema "role" do
    field :name, :string

    timestamps()

    many_to_many :principals, Gatehouse.Principal, join_through: "principals_to_roles"
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc false
  def changeset(%Role{} = role, attrs) do
    role
      |> cast(attrs, @required_fields, @optional_fields)
      |> unique_constraint(:name)
  end
end

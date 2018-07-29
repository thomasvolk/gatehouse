defmodule Gatehouse.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gatehouse.Role
  alias Gatehouse.Principal

  @role_admin :GatehouseAdmin

  def role_admin, do: @role_admin

  schema "role" do
    field :name, :string

    timestamps()

    many_to_many :principals, Principal, join_through: "principals_to_roles"
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

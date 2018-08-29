defmodule Gatehouse.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gatehouse.Role
  alias Gatehouse.Principal

  @role_admin :GatehouseAdmin

  def admin_role(), do: to_string(@role_admin)

  def is_admin_role(name), do: admin_role() == name

  schema "roles" do
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
      |> validate_required([:name])
      |> unique_constraint(:name)
  end
end

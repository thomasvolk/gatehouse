defmodule Gatehouse.Principal do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gatehouse.Principal

  schema "principals" do
    field :email, :string
    field :crypted_password, :string
    field :password, :string, virtual: true

    timestamps()

    many_to_many :roles, Gatehouse.Role, join_through: "principals_to_roles"
  end

  @required_fields ~w(email password)
  @optional_fields ~w()

  @doc false
  def changeset(%Principal{} = principal, attrs) do
    principal
      |> cast(attrs, @required_fields, @optional_fields)
      |> unique_constraint(:email)
      |> validate_format(:email, ~r/@/)
      |> validate_length(:password, min: 8)
  end
end

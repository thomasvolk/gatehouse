defmodule Gatehouse.Principal do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gatehouse.Principal
  alias Gatehouse.Role

  def pwhash(password), do: Comeonin.Bcrypt.hashpwsalt(password)

  schema "principals" do
    field :email, :string
    field :crypted_password, :string
    field :password, :string, virtual: true

    timestamps()

    many_to_many :roles, Role, join_through: "principals_to_roles", on_replace: :delete
  end

  @required_fields ~w(email password)
  @optional_fields ~w()

  @doc false
  def changeset(%Principal{} = principal, attrs) do
    principal
      |> cast(attrs, @required_fields, @optional_fields)
      |> validate_required([:password, :email])
      |> unique_constraint(:email)
      |> validate_format(:email, ~r/.+@.+\..+/)
      |> validate_length(:password, min: 8)
  end
end

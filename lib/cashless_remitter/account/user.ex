defmodule CashlessRemitter.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    field(:order_count, :integer)
    field(:phone_number, :string)
    field(:pin, :integer)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :phone_number, :order_count, :pin])
    |> validate_required([:name, :email, :phone_number, :order_count, :pin])
  end
end

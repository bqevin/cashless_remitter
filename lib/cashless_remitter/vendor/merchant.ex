defmodule CashlessRemitter.Vendor.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchants" do
    field(:closing, :time)
    field(:description, :string)
    field(:logo, :string)
    field(:name, :string)
    field(:opening, :time)
    field(:phone, :string)

    timestamps()
  end

  @doc false
  def changeset(merchant, attrs) do
    merchant
    |> cast(attrs, [:name, :logo, :description, :phone, :opening, :closing])
    |> validate_required([:name, :logo, :description, :phone, :opening, :closing])
  end
end

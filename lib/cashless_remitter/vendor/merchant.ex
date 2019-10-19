defmodule CashlessRemitter.Vendor.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchants" do
    field(:closing_time, :time)
    field(:description, :string)
    field(:logo, :string)
    field(:name, :string)
    field(:opening_time, :time)
    field(:phone, :string)

    timestamps()
  end

  @doc false
  def changeset(merchant, attrs) do
    merchant
    |> cast(attrs, [:name, :logo, :description, :phone, :opening_time, :closing_time])
    |> validate_required([:name, :logo, :description, :phone, :opening_time, :closing_time])
  end
end

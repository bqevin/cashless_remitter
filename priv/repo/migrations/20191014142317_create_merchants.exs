defmodule CashlessRemitter.Repo.Migrations.CreateMerchants do
  use Ecto.Migration

  def change do
    create table(:merchants) do
      add(:name, :string, null: false)
      add(:logo, :string)
      add(:description, :string)
      add(:phone, :string, null: false)
      add(:opening_time, :time, null: false)
      add(:closing_time, :time, null: false)

      timestamps()
    end
  end
end

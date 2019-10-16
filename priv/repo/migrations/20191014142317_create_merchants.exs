defmodule CashlessRemitter.Repo.Migrations.CreateMerchants do
  use Ecto.Migration

  def change do
    create table(:merchants) do
      add(:name, :string)
      add(:logo, :string)
      add(:description, :string)
      add(:phone, :string)
      add(:opening_time, :time)
      add(:closing_time, :time)

      timestamps()
    end
  end
end

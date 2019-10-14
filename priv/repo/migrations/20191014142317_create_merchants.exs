defmodule CashlessRemitter.Repo.Migrations.CreateMerchants do
  use Ecto.Migration

  def change do
    create table(:merchants) do
      add :name, :string
      add :logo, :string
      add :description, :string
      add :phone, :string
      add :opening, :time
      add :closing, :time

      timestamps()
    end

  end
end

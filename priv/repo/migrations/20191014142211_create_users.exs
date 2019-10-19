defmodule CashlessRemitter.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)
      add(:email, :string, null: false)
      add(:phone_number, :string, null: false)
      add(:order_count, :integer)
      add(:pin, :integer)

      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end

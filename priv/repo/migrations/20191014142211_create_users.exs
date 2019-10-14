defmodule CashlessRemitter.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :phone_number, :string
      add :order_count, :integer
      add :pin, :integer

      timestamps()
    end

  end
end

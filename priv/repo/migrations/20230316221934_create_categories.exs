defmodule AbaeteFestApi.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false
      add :type, :string, null: false

      timestamps()
    end
  end
end

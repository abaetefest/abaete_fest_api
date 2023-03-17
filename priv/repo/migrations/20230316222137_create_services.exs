defmodule AbaeteFestApi.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :address, :text
      add :phone, :string
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:services, [:category_id])
  end
end

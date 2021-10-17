defmodule AbaeteFestApi.Repo.Migrations.AddCategoryOnEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :category, :string
    end
  end
end

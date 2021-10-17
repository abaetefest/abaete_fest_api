defmodule AbaeteFestApi.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :image_url, :string
      add :name, :string
      add :description, :text

      timestamps()
    end
  end
end

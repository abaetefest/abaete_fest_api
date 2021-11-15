defmodule AbaeteFestApi.Repo.Migrations.CreateAttractions do
  use Ecto.Migration

  def change do
    create table(:attractions) do
      add :image_url, :string
      add :name, :string
      add :description, :text
      add :address, :string
      add :latitude, :string
      add :longitude, :string

      timestamps()
    end
  end
end

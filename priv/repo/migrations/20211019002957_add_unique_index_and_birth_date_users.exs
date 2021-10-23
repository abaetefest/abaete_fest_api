defmodule AbaeteFestApi.Repo.Migrations.AddUniqueIndexAndBirthDateUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :birth_date, :string
    end
    create unique_index(:users, [:email])
  end
end

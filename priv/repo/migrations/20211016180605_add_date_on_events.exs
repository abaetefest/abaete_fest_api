defmodule AbaeteFestApi.Repo.Migrations.AddDateOnEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :start_date, :string
    end
  end
end

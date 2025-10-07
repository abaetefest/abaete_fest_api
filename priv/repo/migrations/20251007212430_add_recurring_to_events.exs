defmodule AbaeteFestApi.Repo.Migrations.AddRecurringToEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :recurring, :boolean, default: false, null: false
    end
  end
end

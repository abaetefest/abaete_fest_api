defmodule AbaeteFestApi.Repo.Migrations.AddRecurringDaysToEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :recurring_days, :string
    end
  end
end

defmodule AbaeteFestApi.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :description, :string

    field :category, Ecto.Enum,
      values: [
        :parties,
        :cultural,
        :religious,
        :sports,
        :geek,
        :tourism,
        :educational,
        :automotive,
        :carnival,
        :bluemenau_sports
      ]

    field :start_date, :string
    field :image_url, :string
    field :name, :string
    field :recurring, :boolean
    field :recurring_days, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:image_url, :name, :description, :start_date, :category, :recurring, :recurring_days])
    |> validate_required([:image_url, :name, :description, :category, :recurring])
    |> validate_recurring_days
  end

  defp validate_recurring_days(changeset) do
    case get_field(changeset, :recurring) do
      true ->
        changeset
        |> validate_required([:recurring_days])

      _ ->
        changeset
    end
  end
end

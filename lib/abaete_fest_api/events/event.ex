defmodule AbaeteFestApi.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :description, :string
    field :category, Ecto.Enum, values: [:parties, :cultural, :religious, :sports, :geek, :tourism, :educational, :automotive]
    field :start_date, :string
    field :image_url, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:image_url, :name, :description, :start_date, :category ])
    |> validate_required([:image_url, :name, :description, :category])
  end
end

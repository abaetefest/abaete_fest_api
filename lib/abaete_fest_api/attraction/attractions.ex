defmodule AbaeteFestApi.Attraction.Attractions do
  use Ecto.Schema
  import Ecto.Changeset

  schema "attractions" do
    field :address, :string
    field :description, :string
    field :image_url, :string
    field :latitude, :string
    field :longitude, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(attractions, attrs) do
    attractions
    |> cast(attrs, [:image_url, :name, :description, :address, :latitude, :longitude])
    |> validate_required([:image_url, :name, :description, :address, :latitude, :longitude])
  end
end

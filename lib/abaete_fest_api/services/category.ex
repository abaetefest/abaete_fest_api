defmodule AbaeteFestApi.Services.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    field :type, Ecto.Enum, values: [:services, :locations], default: :services

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :type])
    |> validate_required([:name, :type])
  end
end

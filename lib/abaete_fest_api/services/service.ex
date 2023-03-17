defmodule AbaeteFestApi.Services.Service do
  use Ecto.Schema
  import Ecto.Changeset

  schema "services" do
    field :address, :string
    field :description, :string
    field :phone, :string
    field :title, :string
    field :category_id, :id

    timestamps()
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:title, :description, :address, :phone, :category_id])
    |> validate_required([:title, :description, :category_id])
  end
end

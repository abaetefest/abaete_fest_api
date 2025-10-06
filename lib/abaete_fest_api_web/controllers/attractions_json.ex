defmodule AbaeteFestApiWeb.AttractionsJSON do
  alias AbaeteFestApi.Attractions.Attraction
  import AbaeteFestApiWeb.ImageHelpers

  @doc """
  Renders a list of attractions.
  """
  def index(%{attractions: attractions}) do
    %{data: for(attraction <- attractions, do: data(attraction))}
  end

  @doc """
  Renders a single attraction.
  """
  def show(%{attractions: attraction}) do
    %{data: data(attraction)}
  end

  defp data(%Attraction{} = attraction) do
    %{
      id: attraction.id,
      image_url: image_url_signed(attraction.image_url),
      name: attraction.name,
      description: attraction.description,
      address: attraction.address,
      latitude: attraction.latitude,
      longitude: attraction.longitude
    }
  end
end

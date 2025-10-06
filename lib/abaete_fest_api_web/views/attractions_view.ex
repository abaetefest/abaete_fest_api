defmodule AbaeteFestApiWeb.AttractionsView do
  use AbaeteFestApiWeb, :view
  alias AbaeteFestApiWeb.AttractionsView

  def render("index.json", %{attractions: attractions}) do
    %{data: render_many(attractions, AttractionsView, "attractions.json")}
  end

  def render("show.json", %{attractions: attractions}) do
    %{data: render_one(attractions, AttractionsView, "attractions.json")}
  end

  def render("attractions.json", %{attractions: attractions}) do
    %{
      id: attractions.id,
      image_url: image_url_signed(attractions.image_url),
      name: attractions.name,
      description: attractions.description,
      address: attractions.address,
      latitude: attractions.latitude,
      longitude: attractions.longitude
    }
  end
end

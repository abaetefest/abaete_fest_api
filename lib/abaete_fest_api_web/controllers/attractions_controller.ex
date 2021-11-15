defmodule AbaeteFestApiWeb.AttractionsController do
  use AbaeteFestApiWeb, :controller

  alias AbaeteFestApi.Attraction
  alias AbaeteFestApi.Attraction.Attractions

  action_fallback AbaeteFestApiWeb.FallbackController

  def index(conn, _params) do
    attractions = Attraction.list_attractions()
    render(conn, "index.json", attractions: attractions)
  end

  def create(conn, attractions_params) do
    with {:ok, %Attractions{} = attractions} <-
           Attraction.create_attractions(
             attractions_params,
             Map.get(attractions_params, "image_url", "")
           ) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.attractions_path(conn, :show, attractions))
      |> render("show.json", attractions: attractions)
    end
  end

  def show(conn, %{"id" => id}) do
    attractions = Attraction.get_attractions!(id)
    render(conn, "show.json", attractions: attractions)
  end

  def update(conn, %{"id" => id} = attractions_params) do
    attractions = Attraction.get_attractions!(id)

    with {:ok, %Attractions{} = attractions} <-
           Attraction.update_attractions(
             attractions,
             attractions_params,
             Map.get(attractions_params, "image_url", "")
           ) do
      render(conn, "show.json", attractions: attractions)
    end
  end

  def delete(conn, %{"id" => id}) do
    attractions = Attraction.get_attractions!(id)

    with {:ok, %Attractions{}} <- Attraction.delete_attractions(attractions) do
      send_resp(conn, :no_content, "")
    end
  end
end

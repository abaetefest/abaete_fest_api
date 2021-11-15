defmodule AbaeteFestApi.AttractionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AbaeteFestApi.Attraction` context.
  """

  @doc """
  Generate a attractions.
  """
  def attractions_fixture(attrs \\ %{}) do
    {:ok, attractions} =
      attrs
      |> Enum.into(%{
        address: "some address",
        description: "some description",
        image_url: "some image_url",
        latitude: "some latitude",
        longitude: "some longitude",
        name: "some name"
      })
      |> AbaeteFestApi.Attraction.create_attractions()

    attractions
  end
end

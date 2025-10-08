defmodule AbaeteFestApi.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AbaeteFestApi.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image_url: "some image_url",
        name: "some name",
        category: :sports,
        recurring: false
      })
      |> AbaeteFestApi.Events.create_event()

    event
  end
end

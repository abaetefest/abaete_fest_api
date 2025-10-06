defmodule AbaeteFestApiWeb.EventJSON do
  alias AbaeteFestApi.Events.Event
  import AbaeteFestApiWeb.ImageHelpers

  @doc """
  Renders a list of events.
  """
  def index(%{events: events}) do
    %{data: for(event <- events, do: data(event))}
  end

  @doc """
  Renders a single event.
  """
  def show(%{event: event}) do
    %{data: data(event)}
  end

  defp data(%Event{} = event) do
    %{
      id: event.id,
      image_url: image_url_signed(event.image_url),
      name: event.name,
      description: event.description,
      start_date: event.start_date,
      category: event.category
    }
  end
end

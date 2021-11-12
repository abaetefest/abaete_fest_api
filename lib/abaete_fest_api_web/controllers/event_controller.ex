defmodule AbaeteFestApiWeb.EventController do
  use AbaeteFestApiWeb, :controller

  alias AbaeteFestApi.Events
  alias AbaeteFestApi.Events.Event

  action_fallback AbaeteFestApiWeb.FallbackController

  def index(conn, %{"category" => category} = _params) do
    events = Events.list_events(%{category: category})
    render(conn, "index.json", events: events)
  end

  def index(conn, _params) do
    events = Events.list_events()
    render(conn, "index.json", events: events)
  end

  def create(conn, event_params) do
    with {:ok, %Event{} = event} <-
           Events.create_event(event_params, Map.get(event_params, "image_url", "")) do
      %{"content_push" => content, "name" => subject} = event_params
      AbaeteFestApi.PushNotifications.send(subject, content, event.id)

      conn
      |> put_status(:created)
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Events.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id} = event_params) do
    event = Events.get_event!(id)

    with {:ok, %Event{} = event} <-
           Events.update_event(event, event_params, Map.get(event_params, "image_url", "")) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Events.get_event!(id)

    with {:ok, %Event{}} <- Events.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end

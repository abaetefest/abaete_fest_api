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
      subject = Map.get(event_params, "name")
      content = Map.get(event_params, "content_push")
      recurring = Map.get(event_params, "recurring", false)
      recurring_bool = case recurring do
        "true" -> true
        "false" -> false
        true -> true
        false -> false
        _ -> false
      end

      if is_binary(content) and String.trim(content) != "" and not recurring_bool do
        AbaeteFestApi.PushNotifications.send(subject, content, event.id)
      end

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

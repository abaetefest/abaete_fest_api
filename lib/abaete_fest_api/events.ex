defmodule AbaeteFestApi.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias AbaeteFestApi.Repo

  alias AbaeteFestApi.Events.Event

  def list_events(filters \\ %{}) do
    build_query(filters)
    |> Repo.all()
  end

  defp base_query() do
    from(events in Event)
  end

  defp build_query(filters) do
    query = base_query()

    query
    |> maybe_filter_by_category(filters[:category])
    |> filter_future_events()
  end

  defp maybe_filter_by_category(query, nil), do: query

  defp maybe_filter_by_category(query, category_name) do
    from(events in query,
      where: events.category == ^category_name
    )
  end

  defp filter_future_events(query) do
    from(events in query,
      where: fragment("?::date", events.start_date) >= ^Timex.today(),
      order_by: [asc: events.start_date]
    )
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}, file) do
    file_url = upload_images(file)

    case file_url do
      {:ok, file_url} -> do_create(file_url, attrs)
      {:error, reason} -> {:error, reason}
    end
  end

  defp do_create(file_url, attrs) do
    event = Map.merge(attrs, %{"image_url" => file_url})

    %Event{}
    |> Event.changeset(event)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs, file) do
    case file do
      "" ->
        do_update(event, attrs)

      nil ->
        do_update(event, attrs)

      _ ->
        file_url = upload_images(file)

        case file_url do
          {:ok, file_url} -> do_update(event, attrs, file_url)
          {:error, reason} -> {:error, reason}
        end
    end
  end

  defp do_update(%Event{} = event, attrs) do
    action_update(event, attrs)
  end

  defp do_update(%Event{} = event, attrs, file_url) do
    attrs = Map.merge(attrs, %{"image_url" => file_url})
    action_update(event, attrs)
  end

  defp action_update(event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  def upload_images(file) do
    AbaeteFestApi.Uploader.upload("images", file)
  end

  @doc """
  Deletes a event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{data: %Event{}}

  """
  def change_event(%Event{} = event, attrs \\ %{}) do
    Event.changeset(event, attrs)
  end
end

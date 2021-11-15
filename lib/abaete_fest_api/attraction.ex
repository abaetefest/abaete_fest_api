defmodule AbaeteFestApi.Attraction do
  @moduledoc """
  The Attraction context.
  """

  import Ecto.Query, warn: false
  alias AbaeteFestApi.Repo

  alias AbaeteFestApi.Attraction.Attractions

  @doc """
  Returns the list of attractions.

  ## Examples

      iex> list_attractions()
      [%Attractions{}, ...]

  """
  def list_attractions do
    Repo.all(Attractions)
  end

  @doc """
  Gets a single attractions.

  Raises `Ecto.NoResultsError` if the Attractions does not exist.

  ## Examples

      iex> get_attractions!(123)
      %Attractions{}

      iex> get_attractions!(456)
      ** (Ecto.NoResultsError)

  """
  def get_attractions!(id), do: Repo.get!(Attractions, id)

  @doc """
  Creates a attractions.

  ## Examples

      iex> create_attractions(%{field: value})
      {:ok, %Attractions{}}

      iex> create_attractions(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_attractions(attrs \\ %{}, file) do
    file_url = upload_images(file)

    case file_url do
      {:ok, file_url} -> do_create(file_url, attrs)
      {:error, reason} -> {:error, reason}
    end
  end

  defp do_create(file_url, attrs) do
    attraction = Map.merge(attrs, %{"image_url" => file_url})

    %Attractions{}
    |> Attractions.changeset(attraction)
    |> Repo.insert()
  end

  @doc """
  Updates a attractions.

  ## Examples

      iex> update_attractions(attractions, %{field: new_value})
      {:ok, %Attractions{}}

      iex> update_attractions(attractions, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_attractions(%Attractions{} = attraction, attrs, file) do
    case file do
      "" ->
        do_update(attraction, attrs)

      nil ->
        do_update(attraction, attrs)

      _ ->
        file_url = upload_images(file)

        case file_url do
          {:ok, file_url} -> do_update(attraction, attrs, file_url)
          {:error, reason} -> {:error, reason}
        end
    end
  end

  defp do_update(%Attractions{} = attraction, attrs) do
    action_update(attraction, attrs)
  end

  defp do_update(%Attractions{} = attraction, attrs, file_url) do
    attrs = Map.merge(attrs, %{"image_url" => file_url})
    action_update(attraction, attrs)
  end

  defp action_update(attraction, attrs) do
    attraction
    |> Attractions.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a attractions.

  ## Examples

      iex> delete_attractions(attractions)
      {:ok, %Attractions{}}

      iex> delete_attractions(attractions)
      {:error, %Ecto.Changeset{}}

  """
  def delete_attractions(%Attractions{} = attractions) do
    Repo.delete(attractions)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking attractions changes.

  ## Examples

      iex> change_attractions(attractions)
      %Ecto.Changeset{data: %Attractions{}}

  """
  def change_attractions(%Attractions{} = attractions, attrs \\ %{}) do
    Attractions.changeset(attractions, attrs)
  end

  def upload_images(file) do
    AbaeteFestApi.Uploader.upload("images", file)
  end
end

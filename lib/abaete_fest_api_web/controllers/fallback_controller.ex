defmodule AbaeteFestApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use AbaeteFestApiWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(AbaeteFestApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(AbaeteFestApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, {:error, _reason}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(AbaeteFestApiWeb.ErrorView)
    |> render(:"422")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(AbaeteFestApiWeb.ErrorView)
    |> render(:"401")
  end
end

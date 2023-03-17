defmodule AbaeteFestApi.ServicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AbaeteFestApi.Services` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "some name",
        type: :services
      })
      |> AbaeteFestApi.Services.create_category()

    category
  end

  @doc """
  Generate a service.
  """
  def service_fixture(attrs \\ %{}) do
    {:ok, service} =
      attrs
      |> Enum.into(%{
        address: "some address",
        description: "some description",
        phone: "some phone",
        title: "some title"
      })
      |> AbaeteFestApi.Services.create_service()

    service
  end
end

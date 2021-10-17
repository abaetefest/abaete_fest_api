defmodule AbaeteFestApi.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AbaeteFestApi.Account` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        is_admin: true,
        name: "some name",
        password_hash: "some password_hash",
        phone: "some phone"
      })
      |> AbaeteFestApi.Account.create_user()

    user
  end
end

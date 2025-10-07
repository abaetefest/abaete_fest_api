defmodule AbaeteFestApiWeb.UserJSON do
  alias AbaeteFestApi.Account.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  def show(%{user: user, token: token}) do
    %{data: data(user, token)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      is_admin: user.is_admin
    }
  end

  defp data(%User{} = user, token) do
    %{
      id: user.id,
      email: user.email,
      token: token,
      is_admin: user.is_admin
    }
  end
end

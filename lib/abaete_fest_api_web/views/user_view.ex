defmodule AbaeteFestApiWeb.UserView do
  use AbaeteFestApiWeb, :view
  alias AbaeteFestApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user, token: token}) do
    %{
      id: user.id,
      email: user.email,
      token: token,
      is_admin: user.is_admin
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      is_admin: user.is_admin
    }
  end
end

defmodule AbaeteFestApiWeb.ServiceView do
  use AbaeteFestApiWeb, :view
  alias AbaeteFestApiWeb.ServiceView

  def render("index.json", %{services: services}) do
    %{data: render_many(services, ServiceView, "service.json")}
  end

  def render("show.json", %{service: service}) do
    %{data: render_one(service, ServiceView, "service.json")}
  end

  def render("service.json", %{service: service}) do
    %{
      id: service.id,
      title: service.title,
      description: service.description,
      address: service.address,
      phone: service.phone
    }
  end
end

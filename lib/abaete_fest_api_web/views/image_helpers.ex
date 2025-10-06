defmodule AbaeteFestApiWeb.ImageHelpers do
  @moduledoc false

  def image_url_signed(nil), do: "#"
  def image_url_signed(""), do: "#"

  def image_url_signed(path) do
    with {:ok, url} <- AbaeteFestApi.Uploader.get_presigned_url(path), do: url
  end

  def image_url_unsigned(path), do: AbaeteFestApi.Uploader.get_url(path)

  def image_path(path), do: image_path(AbaeteFestApiWeb.Endpoint, path)

  def image_path(endpoint, path) do
    AbaeteFestApiWeb.Router.Helpers.static_path(endpoint, path)
  end

  def image_url(path), do: image_url(AbaeteFestApiWeb.Endpoint, path)

  def image_url(endpoint, path) do
    AbaeteFestApiWeb.Endpoint.config(:app_url) <> image_path(endpoint, path)
  end

  def logo_url(nil), do: ""

  def logo_url(logo), do: image_url_unsigned(logo)
end

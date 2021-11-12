defmodule AbaeteFestApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :abaete_fest_api,
    module: AbaeteFestApiWeb.Auth.Guardian,
    error_handler: AbaeteFestApiWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end

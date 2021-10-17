defmodule AbaeteFestApi.Repo do
  use Ecto.Repo,
    otp_app: :abaete_fest_api,
    adapter: Ecto.Adapters.Postgres
end

defmodule Tex.Repo do
  use Ecto.Repo,
    otp_app: :tex,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end

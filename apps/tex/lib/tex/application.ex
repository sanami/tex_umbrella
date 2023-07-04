defmodule Tex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Tex.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Tex.PubSub}
      # Start a worker by calling: Tex.Worker.start_link(arg)
      # {Tex.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Tex.Supervisor)
  end
end

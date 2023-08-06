defmodule TexWeb.Router do
  use TexWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TexWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TexWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/my_text", PageController, :my_text
    get "/my_json", PageController, :my_json

    resources "/admin/stories", StoryController, only: [:index, :show]

    live "/story", StoryLive.Index
    live "/story/:story_id", StoryLive.Index, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", TexWeb do
  #   pipe_through :api
  # end
end

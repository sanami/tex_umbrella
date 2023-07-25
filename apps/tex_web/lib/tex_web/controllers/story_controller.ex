defmodule TexWeb.StoryController do
  use TexWeb, :controller

  alias Tex.Stories

  def index(conn, _params) do
    stories = Stories.list_stories(limit: 1000)
    render(conn, :index, stories: stories)
  end

  def show(conn, %{"id" => id}) do
    story = Stories.get_story!(id)
    render(conn, :show, story: story)
  end
end

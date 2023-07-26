defmodule TexWeb.StoryController do
  use TexWeb, :controller

  alias Tex.Stories

  def index(conn, params) do
    cats = Stories.list_story_categories
    stories = Stories.list_stories(limit: 100, author_id: params["author_id"], cat_id: params["cat_id"])

    render(conn, :index, stories: stories, cats: cats)
  end

  def show(conn, %{"id" => id}) do
    story = Stories.get_story!(id)
#    conn = put_flash(conn, :info, [story.title])
#    render(conn, :show, story: story, layout: {TexWeb.Layouts, :app})
    render(conn, :show, story: story)
  end
end

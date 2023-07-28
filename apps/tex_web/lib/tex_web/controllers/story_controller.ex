defmodule TexWeb.StoryController do
  use TexWeb, :controller

  alias Tex.{Repo, Stories}

  def index(conn, params) do
    story_categories = Stories.list_story_categories

    page =
      Tex.Stories.list_stories(author_id: params["author_id"], cat_id: params["cat_id"])
      |> Repo.paginate(params)

    stories =
      page.entries
      |> Repo.preload([:story_author, :story_categories])

    render(conn, :index, stories: stories, story_categories: story_categories, page: page)
  end

  def show(conn, %{"id" => id}) do
    story = Stories.get_story!(id)
#    conn = put_flash(conn, :info, [story.title])
#    render(conn, :show, story: story, layout: {TexWeb.Layouts, :app})
    render(conn, :show, story: story)
  end
end

defmodule TexWeb.StoryController do
  use TexWeb, :controller

  alias Tex.{Repo, Stories}

  def index(conn, params) do
    filter_params =
      params
      |> Map.take(~w[author_id cat_id rating])
      |> Map.filter(fn {_key, val} -> val && val != "" end)
      |> Keyword.new(fn {key, val} -> {String.to_existing_atom(key), val} end)

    story_categories = Stories.list_story_categories

    page =
      Tex.Stories.list_stories(filter_params)
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

defmodule Tex.Stories do
  import Ecto.Query, warn: false

  alias Tex.Repo
  alias Tex.Stories.StoryCategory
  alias Tex.Stories.StoryAuthor

  def count(module) do
    module |> select([p], count(p.id)) |> Repo.one
  end

  def list_story_categories do
    Repo.all(StoryCategory)
  end

  def get_story_category!(id), do: Repo.get!(StoryCategory, id)

  def create_story_category(attrs \\ %{}) do
    %StoryCategory{}
    |> StoryCategory.changeset(attrs)
    |> Repo.insert()
  end

  def list_story_authors do
    Repo.all(StoryAuthor)
  end

  def get_story_author!(id), do: Repo.get!(StoryAuthor, id)

  def create_story_author(attrs \\ %{}) do
    %StoryAuthor{}
    |> StoryAuthor.changeset(attrs)
    |> Repo.insert()
  end
end

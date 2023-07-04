defmodule Tex.Stories do
  import Ecto.Query, warn: false
  alias Tex.Repo

  alias Tex.Stories.StoryCategory

  def list_story_categories do
    Repo.all(StoryCategory)
  end

  def count_story_categories do
    StoryCategory |> select([p], count(p.id)) |> Repo.one
  end

  def get_story_category!(id), do: Repo.get!(StoryCategory, id)

  def create_story_category(attrs \\ %{}) do
    %StoryCategory{}
    |> StoryCategory.changeset(attrs)
    |> Repo.insert()
  end
end

defmodule Tex.Stories do
  import Ecto.Query, warn: false

  alias Tex.Repo
  alias Tex.Stories.{StoryCategory, StoryAuthor, Story}

  def count(module) do
    module |> select([p], count(p.id)) |> Repo.one
  end

  def list_story_categories do
    Repo.all(StoryCategory)
  end

  def get_story_category!(id), do: Repo.get!(StoryCategory, id)

  def get_story_categories(oids) do
    StoryCategory |> where([t], t.oid in ^oids) |> Repo.all
  end

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

  def list_stories do
    Repo.all(Story)
  end

  def get_story!(id), do: Repo.get!(Story, id)

  def create_story(attrs \\ %{}) do
    %Story{}
    |> Story.changeset(attrs)
    |> Repo.insert()
  end

  def set_story_categories(story, category_ids) do
    story
    |> Repo.preload(:story_categories)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:story_categories, category_ids)
    |> Repo.update!
  end
end

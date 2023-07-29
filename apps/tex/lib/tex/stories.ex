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

  def list_stories(args \\ []) do
    author_id = Keyword.get(args, :author_id, nil)
    cat_id = Keyword.get(args, :cat_id, nil)
    rating = Keyword.get(args, :rating, nil)

    q = Story

    q = if author_id do
      from s in q, join: a in assoc(s, :story_author), where: a.id == ^author_id
    else
      q
    end

    q = if rating do
      where(q, [t], t.rating > ^rating and t.rating_count > 10)
    else
      q
    end

    q = if cat_id && cat_id != "" do
      from s in q, join: c in assoc(s, :story_categories), where: c.id == ^cat_id
    else
      q
    end

    # q |> order_by(:title)
    # q |> order_by(desc: :rating)

    q
  end

  def get_story!(id), do: Repo.get!(Story, id)

  def create_story(attrs \\ %{}) do
    %Story{}
    |> Story.changeset(attrs)
    |> Repo.insert()
  end

  def set_story_categories(story, {:objects, cats}) do
    story
    |> Repo.preload(:story_categories)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:story_categories, cats)
    |> Repo.update!
  end

  def set_story_categories(story, {:ids, cat_ids}) do
    entries = Enum.map cat_ids, & %{story_id: story.id, story_category_id: &1}
    Repo.insert_all "stories_categories_join", entries
  end
end

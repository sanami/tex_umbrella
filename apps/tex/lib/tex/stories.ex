defmodule Tex.Stories do
  import Ecto.Query, warn: false
  require Logger

  alias Tex.Repo
  alias Tex.Stories.{StoryCategory, StoryAuthor, Story}

  def count(module) do
    Repo.aggregate(module, :count)
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

  def list_stories(args \\ %{}, is_favorites \\ false) do
    query = args["query"]
    author_id = args["author_id"]
    cat_ids = args["cat_ids"]
    rating = args["rating"]
    sort = (args["sort"] || "story_date") |> String.to_existing_atom
    sort_dir = (args["sort_dir"] || "asc") |> String.to_existing_atom

    q = Story

    q = if is_favorites do
      from s in q, where: not is_nil(s.favorited_at)
    else
      q
    end

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

    q = if cat_ids && cat_ids != [] do
      cat_ids = List.flatten [cat_ids]
      Enum.reduce cat_ids, q, fn cat_id, q ->
        if cat_id && cat_id != "" do
          from s in q, join: c in assoc(s, :story_categories), where: c.id == ^cat_id
        else
          q
        end
      end
    else
      q
    end

    q = if is_favorites do
      order_by(q, desc: :favorited_at)
    else
      order_by(q, {^sort_dir, ^sort})
    end

    q = if query && String.length(query) > 2 do
      # PHRASETO_TSQUERY
      from s in q, where: fragment("TO_TSVECTOR('russian', story_body) @@ PLAINTO_TSQUERY('russian', ?)", ^query)
    else
      q
    end

    q
  end

  def get_story!(id), do: Repo.get!(Story, id)

  def create_story(attrs \\ %{}) do
    %Story{}
    |> Story.changeset(attrs)
    |> Repo.insert()
  end

  def set_favorite(id) do
    story = Repo.get!(Story, id)
    favorited_at = if story.favorited_at, do: nil, else: DateTime.now!("Etc/UTC")
    # Logger.debug "favorited_at = #{favorited_at}"

    story
    |> Story.changeset(%{favorited_at: favorited_at})
    |> Repo.update!
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

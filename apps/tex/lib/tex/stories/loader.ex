defmodule Tex.Stories.Loader do
  import Logger
  import Ecto.Query

  alias Tex.{Repo, Stories}
  alias Tex.Stories.{StoryCategory, StoryAuthor}

  def parse_bsondump(file, obj_fn) do
    file
    |> File.stream!([:read], :line)
    |> Stream.with_index
    |> Enum.reduce(0, fn {json_str, i}, _acc ->
      json = Jason.decode!(json_str, keys: :atoms)

      json
      |> Map.put(:oid, json[:_id][:"$oid"])
      |> Map.delete(:_id)
      |> obj_fn.(i)

      i + 1
    end)
  end

  def load_categories(bd_file) do
    parse_bsondump bd_file, fn obj, _i ->
      {status, obj} = Stories.create_story_category %{name: obj[:story_category_name], uid: obj[:uid], oid: obj[:oid]}
      if status != :ok, do: Logger.error(obj.errors)
    end
  end

  def load_authors(bd_file) do
    parse_bsondump bd_file, fn obj, _i ->
      {status, obj} = Stories.create_story_author %{name: obj[:story_author_name], uid: obj[:uid], oid: obj[:oid]}
      if status != :ok, do: Logger.error(obj.errors)
    end
  end

  def load_stories(bd_file) do
    parse_bsondump bd_file, fn obj, _i ->
      attrs = %{
        story_date: obj[:story_date][:"$date"],
        story_excerpt: obj[:story_excerpt],
        story_body: Enum.join(obj[:story_body], "\n"),
        rating: obj[:story_rating][:value],
        rating_count: obj[:story_rating][:count],
        title: obj[:story_title],
        uid: obj[:uid],
        story_author_id: find_by_oid(StoryAuthor, obj[:story_author_id][:"$oid"]),
      }

      {status, obj} = Stories.create_story(attrs)
      if status != :ok, do: Logger.error(obj.errors)
    end
  end

  def find_by_oid(module, oid) do
    obj = module |> where(oid: ^oid) |> select([:id]) |> limit(1) |> Repo.one
    obj && obj.id
  end

  def run do
  end
end

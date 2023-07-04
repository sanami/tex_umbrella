defmodule Tex.Stories.Loader do
  alias Tex.Stories.StoryCategory

  def load_categories(json_file) do
    json_file
    |> File.stream!
    |> Jaxon.Stream.from_enumerable
    |> Jaxon.Stream.query([:root])
    |> Stream.each(fn %{"story_category_name" => name, "uid" => uid} = obj ->
        IO.inspect obj
        Tex.Stories.create_story_category(%{name: name, uid: uid})
      end)
    |> Stream.run
  end

  def load_authors(json_file) do
    json_file
    |> File.stream!
    |> Jaxon.Stream.from_enumerable
    |> Jaxon.Stream.query([:root])
    |> Stream.each(fn %{"story_author_name" => name, "uid" => uid} ->
        Tex.Stories.create_story_author(%{name: name, uid: uid})
      end)
    |> Stream.run
  end

  def run do
  end
end

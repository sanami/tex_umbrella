defmodule Tex.Stories.Loader do
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
      Tex.Stories.create_story_category %{name: obj[:story_category_name], uid: obj[:uid], oid: obj[:oid]}
    end
  end

  def load_authors(bd_file) do
    parse_bsondump bd_file, fn obj, _i ->
      Tex.Stories.create_story_author %{name: obj[:story_author_name], uid: obj[:uid], oid: obj[:oid]}
    end
  end

  def run do
  end
end

defmodule Tex.Stories.LoaderTest do
  use Tex.DataCase

  alias Tex.Stories
  alias Tex.Stories.{Loader, StoryAuthor, StoryCategory}

  @category1 "priv/repo/data/story_categories.json"
  @authors1 "priv/repo/data/story_authors.json"

  test "load_categories" do
    Loader.load_categories(@category1)
    assert Stories.count(StoryCategory) == 38
  end

  test "load_authors" do
    Loader.load_authors(@authors1)
    assert Stories.count(StoryAuthor) > 5000
  end

  test "run" do
    res = Loader.run
    IO.inspect res
  end
end

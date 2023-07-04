defmodule Tex.Stories.LoaderTest do
  use Tex.DataCase

  alias Tex.Stories.Loader

  @category1 "priv/repo/data/story_categories.json"

  test "load_categories" do
    Loader.load_categories(@category1)
    assert Tex.Stories.count_story_categories == 38
  end

  test "run" do
    res = Loader.run
    IO.inspect res
  end
end

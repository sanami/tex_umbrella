defmodule Tex.Stories.LoaderTest do
  use Tex.DataCase

  import Ecto.Query

  alias Tex.{Repo, Stories}
  alias Tex.Stories.{Loader, StoryAuthor, StoryCategory}

  @category1 "priv/repo/data/story_categories.bsondump"
  @authors1 "priv/repo/data/story_authors.bsondump"
  @stories1 "test/support/fixtures/stories.bsondump"

  for {f, n} <- [{@category1, 38}, {@authors1, 5029}, {@stories1, 3}] do
    test "parse_bsondump #{f}" do
      res = Loader.parse_bsondump unquote(f), fn json, i ->
        IO.inspect i
        IO.inspect json
        assert %{uid: _, oid: _} = json
      end

      assert res == unquote(n)
    end
  end

  test "load_categories" do
    Loader.load_categories(@category1)
    assert Stories.count(StoryCategory) == 38

    obj1 = StoryCategory |> first(:id) |> Repo.one
    IO.inspect obj1
  end

  test "load_authors" do
    Loader.load_authors(@authors1)
    assert Stories.count(StoryAuthor) > 5000

    obj1 = StoryAuthor |> first(:id) |> Repo.one
    IO.inspect obj1
  end

  test "run" do
    res = Loader.run
    IO.inspect res
  end
end

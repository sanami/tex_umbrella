defmodule Tex.Stories.LoaderTest do
  use Tex.DataCase

  import Tex.StoriesFixtures
  import Ecto.Query

  alias Tex.{Repo, Stories}
  alias Tex.Stories.{Loader, Story, StoryAuthor, StoryCategory}

  @category1 "priv/repo/data/story_categories.bsondump"
  @authors1 "priv/repo/data/story_authors.bsondump"
  @stories1 "test/support/fixtures/stories.bsondump"

  for {f, n} <- [{@category1, 38}, {@authors1, 5029}] do
    test "parse_bsondump #{f}" do
      res = Loader.parse_bsondump unquote(f), fn json, _i ->
        # IO.inspect i
        # IO.inspect json
        assert %{uid: _, oid: _} = json
      end

      assert res == unquote(n)
    end
  end

  test "parse_bsondump" do
    res = Loader.parse_bsondump @stories1, fn json, i ->
      IO.inspect i
      # IO.inspect Enum.join(json[:story_body], "\n")
      IO.inspect Map.delete(json, :story_body)
      assert %{uid: _, oid: _} = json
    end

    assert res == 3
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

  test "load_stories" do
    Loader.load_categories(@category1)
    Loader.load_authors(@authors1)

    Loader.load_stories(@stories1)
    assert Stories.count(Story) == 3

    obj1 = Story |> first(:id) |> Repo.one |> Repo.preload([:story_author, :story_categories])
    IO.inspect obj1
    assert length(obj1.story_categories) == 1
  end

  test "find_by_oid" do
    cat1 = story_category_fixture()

    res = Loader.find_by_oid(StoryCategory, cat1.oid)
    IO.inspect res
    assert res == cat1.id
    assert Loader.find_by_oid(StoryCategory, "err") == nil
  end

  test "run" do
    res = Loader.run
    IO.inspect res
  end
end

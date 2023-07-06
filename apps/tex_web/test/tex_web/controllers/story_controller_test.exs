defmodule TexWeb.StoryControllerTest do
  use TexWeb.ConnCase

  import Tex.StoriesFixtures

  describe "index" do
    test "lists all stories", %{conn: conn} do
      conn = get(conn, Routes.story_path(conn, :index))
      assert html_response(conn, 200) =~ "Stories"
    end
  end

  defp create_story(_) do
    story = story_fixture()
    %{story: story}
  end
end

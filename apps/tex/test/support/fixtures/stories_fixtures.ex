defmodule Tex.StoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tex.Stories` context.
  """

  @doc """
  Generate a story_category.
  """
  def story_category_fixture(attrs \\ %{}) do
    {:ok, story_category} =
      attrs
      |> Enum.into(%{
        name: "some name",
        uid: 42
      })
      |> Tex.Stories.create_story_category()

    story_category
  end
end

defmodule Tex.Stories.StoryCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "story_categories" do
    field :name, :string
    field :uid, :integer

    timestamps()
  end

  @doc false
  def changeset(story_category, attrs) do
    story_category
    |> cast(attrs, [:uid, :name])
    |> validate_required([:uid, :name])
  end
end

defmodule Tex.Stories.StoryCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "story_categories" do
    field :name, :string
    field :uid, :integer
    field :oid, :string

    timestamps()
  end

  @doc false
  def changeset(story_category, attrs) do
    story_category
    |> cast(attrs, [:uid, :oid, :name])
    |> validate_required([:uid, :oid, :name])
  end
end

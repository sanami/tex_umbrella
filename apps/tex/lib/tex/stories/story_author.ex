defmodule Tex.Stories.StoryAuthor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "story_authors" do
    field :name, :string
    field :uid, :integer
    field :oid, :string

    timestamps()
  end

  @doc false
  def changeset(story_author, attrs) do
    story_author
    |> cast(attrs, [:uid, :oid, :name])
    |> validate_required([:uid, :oid, :name])
  end
end

defmodule Tex.Stories.Story do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stories" do
    field :story_date, :date
    field :story_excerpt, :string
    field :story_body, :string
    field :rating, :float
    field :rating_count, :integer
    field :title, :string
    field :uid, :integer
    belongs_to :story_author, Tex.Stories.StoryAuthor

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:uid, :title, :story_date, :story_excerpt, :story_body, :rating, :rating_count, :story_author_id])
    |> validate_required([:uid, :title, :story_date, :story_excerpt, :story_body, :rating, :rating_count])
  end
end

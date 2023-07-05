defmodule Tex.Repo.Migrations.CreateStories do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :uid, :integer
      add :title, :string, size: 1024
      add :story_date, :date
      add :story_excerpt, :string, size: 1024
      add :story_body, :text
      add :rating, :float
      add :rating_count, :integer

      add :story_author_id, references(:story_authors, on_delete: :nothing)

      timestamps()
    end

    create index(:stories, [:story_author_id])
    create index(:stories, [:uid])
    create index(:stories, [:title])
    create index(:stories, [:story_date])
    create index(:stories, [:rating])
  end
end

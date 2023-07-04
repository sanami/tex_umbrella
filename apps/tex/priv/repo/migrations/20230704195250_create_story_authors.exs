defmodule Tex.Repo.Migrations.CreateStoryAuthors do
  use Ecto.Migration

  def change do
    create table(:story_authors) do
      add :uid, :integer
      add :name, :string

      timestamps()
    end

    create index(:story_authors, [:uid], unique: true)
    create index(:story_authors, [:name], unique: true)
  end
end

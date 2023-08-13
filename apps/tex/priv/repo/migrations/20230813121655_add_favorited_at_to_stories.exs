defmodule Tex.Repo.Migrations.AddFavoritedAtToStories do
  use Ecto.Migration

  def change do
    alter table(:stories) do
      add :favorited_at, :utc_datetime
    end

    create index(:stories, [:favorited_at])
  end
end

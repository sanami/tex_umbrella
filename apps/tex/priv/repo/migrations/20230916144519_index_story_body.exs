defmodule Tex.Repo.Migrations.IndexStoryBody do
  use Ecto.Migration

  def up do
    execute("CREATE INDEX stories_trgm_idx ON stories USING GIN (to_tsvector('russian', story_body))")
  end

  def down do
    execute("DROP INDEX stories_trgm_idx")
  end
end

defmodule TexWeb.Components.Pagination do
  use Phoenix.Component

  embed_templates "pagination/*"

  attr :page, :map, required: true
  attr :path, :any
  attr :rest, :global
  def pagination(assigns)
end
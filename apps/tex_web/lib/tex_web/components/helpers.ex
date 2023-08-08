defmodule TexWeb.Components.Helpers do
  use Phoenix.Component

  embed_templates "helpers/*"

  attr :page, :map, required: true
  attr :path, :any
  attr :rest, :global, default: %{}
  def pagination(assigns)
end
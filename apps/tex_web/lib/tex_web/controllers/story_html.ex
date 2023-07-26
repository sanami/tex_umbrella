defmodule TexWeb.StoryHTML do
  use TexWeb, :html

  embed_templates "story_html/*"

  attr :story, :map
  def story_details(assigns) do
    ~H"""
    <div class="text-sm">
      <%= @story.story_date %>
      <%= @story.rating %>
      <%= @story.rating_count %>
    </div>
    """
  end
end

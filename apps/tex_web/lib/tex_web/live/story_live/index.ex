defmodule TexWeb.StoryLive.Index do
  use TexWeb, :live_view
  alias Tex.{Repo, Stories}
  require Logger

  @impl true
  def mount(params, session, socket) do
    Logger.debug "---mount #{inspect params} #{inspect session} #{socket.id} #{inspect self()}"

    socket = set_stories(socket, params)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, uri, socket) do
    Logger.debug "---handle_params #{socket.assigns[:live_action]} #{inspect params} #{uri} #{socket.id} #{inspect self()}"

    {:noreply, apply_action(socket, socket.assigns[:live_action], params)}
  end

  # Live actions
  defp apply_action(socket, :show, %{"story_id" => story_id}) do
    story = Stories.get_story!(story_id)

    socket
    |> assign(:page_title, story.title)
    |> assign(:story, story)
  end

  defp apply_action(socket, _live_action, params) do
    socket
    |> assign(:page_title, "Рассказы")
    |> set_stories(params)
    |> assign(:story, nil)
  end

  defp set_stories(socket, params) do
    page =
      Stories.list_stories()
      |> Repo.paginate(params)

    stories =
      page.entries
      |> Repo.preload([:story_author, :story_categories])

    assign(socket, stories: stories, page: page)
  end
end

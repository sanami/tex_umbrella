defmodule TexWeb.StoryLive.Index do
  use TexWeb, :live_view
  alias Tex.{Repo, Stories}
  require Logger

  @impl true
  def mount(params, session, socket) do
    Logger.debug "---mount #{inspect params} #{inspect session} #{socket.id} #{inspect self()}"

    page =
      Stories.list_stories()
      |> Repo.paginate(params)

    stories =
      page.entries
      |> Repo.preload([:story_author, :story_categories])

    socket = assign(socket, stories: stories, page: page)

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

  defp apply_action(socket, _live_action, _params) do
    socket
    |> assign(:page_title, "Рассказы")
    |> assign(:story, nil)
  end
end

defmodule TexWeb.PageController do
  use TexWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def my_text(conn, _params) do
    text(conn, "aaa")
  end

  def my_json(conn, _params) do
    json(conn, %{aaa: "bbb"})
  end
end

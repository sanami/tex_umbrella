defmodule TexWeb.PageController do
  use TexWeb, :controller

  def home(conn, _params) do
    # render(conn, :home, layout: false)
    conn
    |> put_flash(:info, "ok")
    |> redirect(to: ~p"/admin/stories")
  end

  def my_text(conn, _params) do
    text(conn, "aaa")
  end

  def my_json(conn, _params) do
    json(conn, %{aaa: "bbb"})
  end
end

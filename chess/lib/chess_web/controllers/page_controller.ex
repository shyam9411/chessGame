defmodule ChessWeb.PageController do
  use ChessWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
  
  def games(conn, %{"name" => name}) do
  	render(conn, "game.html", name: name)
  end
end

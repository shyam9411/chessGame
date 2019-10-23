defmodule ChessWeb.GamesChannel do
  use ChessWeb, :channel

  alias Chess.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      game = Game.new()
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => game}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end
  
  def handle_in("reset", _ , socket) do
    name = socket.assigns[:name]
    game = Game.new()
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
    {:reply, {:ok, %{ "game" => Game.client_view(game) }}, socket}
  end
  
  def handle_in("positionSelected", %{"position" => position} , socket) do
    name = socket.assigns[:name]
    prevGame = socket.assigns[:game]
    game = Game.chessPositionSelected(socket.assigns[:game], position)
    socket = assign(socket, :game, game)
    if game != nil do
		{:reply, {:correct, %{ "game" => Game.client_view(game) }}, socket}
	else
		{:reply, {:wrong, %{ "game" => Game.client_view(game) }}, socket}
	end
  end
  
  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

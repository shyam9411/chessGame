defmodule ChessWeb.GamesChannel do
  use ChessWeb, :channel

  alias Chess.Game
  alias Chess.BackupAgent

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      game = BackupAgent.get(name) || Game.new()
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      BackupAgent.put(name, game)
      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
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
      BackupAgent.put(name, game)
    {:reply, {:ok, %{ "game" => Game.client_view(game) }}, socket}
  end
  
  def handle_in("selectPiece", %{"position" => position} , socket) do
    name = socket.assigns[:name]
    prevGame = socket.assigns[:game]
    game = Game.chessPieceSelected(socket.assigns[:game], position)
    socket = assign(socket, :game, game)
    BackupAgent.put(name, game)
    IO.inspect(game)
    if Enum.count(prevGame.matchedTiles) != Enum.count(game.matchedTiles) || game.selected2 == -1 do
	    IO.inspect("Correct")
		{:reply, {:correct, %{ "game" => Game.client_view(game) }}, socket}
	else
	    IO.inspect("Wrong")
		{:reply, {:wrong, %{ "game" => Game.client_view(game) }}, socket}
	end
  end
  
  def handle_in("selectPosition", %{"position" => position} , socket) do
    name = socket.assigns[:name]
    prevGame = socket.assigns[:game]
    game = Game.chessPositionSelected(socket.assigns[:game], position)
    socket = assign(socket, :game, game)
    BackupAgent.put(name, game)
    IO.inspect(game)
    if Enum.count(prevGame.matchedTiles) != Enum.count(game.matchedTiles) || game.selected2 == -1 do
	    IO.inspect("Correct")
		{:reply, {:correct, %{ "game" => Game.client_view(game) }}, socket}
	else
	    IO.inspect("Wrong")
		{:reply, {:wrong, %{ "game" => Game.client_view(game) }}, socket}
	end
  end
  
  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

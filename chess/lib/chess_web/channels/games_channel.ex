defmodule ChessWeb.GamesChannel do
  use ChessWeb, :channel

  alias Chess.Game
  alias Chess.BackupAgent

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      Chess.GameServer.start(name)
      game = Chess.GameServer.peek(name)
      count = Map.get(game, :countOfPlayers)
      playerName = Map.get(payload, List.first(Map.keys(payload)))
      foundPlayer = Map.has_key?(game.players, playerName)
      game = if (count == 2 and !foundPlayer) do
        viewModePlayers = Map.get(game, :viewMode)
        newList = if (Enum.count(viewModePlayers) == 0) do
          [playerName]
        else
          viewModePlayers ++ [playerName]
        end
        game = Map.put(game, :viewMode, newList)
      else 
        if (!foundPlayer) do
          game = Map.put(game, :countOfPlayers, count + 1)

          newMapOfPlayer = if (Enum.count(Map.keys(game.players)) == 0) do
            %{playerName => "w"}
          else 
            Map.put(game.players, playerName, "b")

          end

          game = Map.put(game, :players, newMapOfPlayer)
        else 
          game
        end
      end

      IO.inspect(game)
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      Chess.GameServer.put(name, game)
      {:ok, %{"join" => name, "game" => game}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end
  
  def handle_in("positionSelected", %{"position" => position} , socket) do
    name = socket.assigns[:name]
    game = Chess.GameServer.positionSelected(name, position)
    isViewMode = Map.get(game, :viewMode)
    resp = if (isViewMode == true) do
      {:reply, {:viewmode, %{ "game" => game }}, socket}
    else
      socket = assign(socket, :game, game)
      if game != nil do
        {:reply, {:correct, %{ "game" => game }}, socket}
      else
        {:reply, {:wrong, %{ "game" => game }}, socket}
      end
    end
    resp
  end
  
  def handle_in("broadcast", _, socket) do
    name = socket.assigns[:name]
    game = Chess.GameServer.peek(name)
    broadcast! socket, "broadcast", %{ "game" => game}
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

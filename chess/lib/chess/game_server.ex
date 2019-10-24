defmodule Chess.GameServer do
    use GenServer
  
    def reg(name) do
      {:via, Registry, {Chess.GameReg, name}}
    end
  
    def start(name) do
      spec = %{
        id: __MODULE__,
        start: {__MODULE__, :start_link, [name]},
        restart: :permanent,
        type: :worker
      }
      Chess.GameSup.start_child(spec)
    end
  
    def start_link(name) do
      game = Chess.BackupAgent.get(name) || Chess.Game.new()
      GenServer.start_link(__MODULE__, game, name: reg(name))
    end
  
    def positionSelected(name, position) do
      GenServer.call(reg(name), {:positionSelected, name, position})
    end
  
    def peek(name) do
      GenServer.call(reg(name), {:peek, name})
    end

    def put(name, game) do
      GenServer.call(reg(name), {:put, name, game})
    end
  
    # Implementation
  
    def init(game) do
      {:ok, game}
    end
  
    def handle_call({:positionSelected, name, position}, _from, game) do
      game = Chess.Game.chessPositionSelected(game, position)
      Chess.BackupAgent.put(name, game)
      {:reply, game, game}
    end
  
    def handle_call({:peek, name}, _from, game) do
      game1 = Chess.BackupAgent.get(name) || Chess.Game.new()
      {:reply, game1, game1}
    end

    def handle_call({:put, name, game1}, _from, game) do
      Chess.BackupAgent.put(name, game1)
      {:reply, game, game}
    end
  end
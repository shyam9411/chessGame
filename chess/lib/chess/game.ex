defmodule Chess.Game do

  alias Chess.Pawn
  alias Chess.Rook
  alias Chess.Knight
  alias Chess.Bishop
  alias Chess.Queen
  alias Chess.King

  @pieces %{
    wKing: 0,
    wQueen: 1,
    wBishop: 2,
    wKnight: 3,
    wRook: 4,
    wPawn: 5,
    bKing: 6,
    bQueen: 7,
    bBishop: 8,
    bKnight: 9,
    bRook: 10,
    bPawn: 11,
    empty: 12
  }

  def new do
    %{
    	board: %{
      	"A1": @pieces.wRook, "B1": @pieces.wKnight, "C1": @pieces.wBishop, "D1": @pieces.wQueen, "E1": @pieces.wKing, "F1": @pieces.wBishop, "G1": @pieces.wKnight, "H1": @pieces.wRook,
      	"A2": @pieces.wPawn, "B2": @pieces.wPawn, "C2": @pieces.wPawn, "D2": @pieces.wPawn, "E2": @pieces.wPawn, "F2": @pieces.wPawn, "G2": @pieces.wPawn, "H2": @pieces.wPawn,
      	"A3": @pieces.empty, "B3": @pieces.empty, "C3": @pieces.empty, "D3": @pieces.empty, "E3": @pieces.empty, "F3": @pieces.empty, "G3": @pieces.empty, "H3": @pieces.empty,
      	"A4": @pieces.empty, "B4": @pieces.empty, "C4": @pieces.empty, "D4": @pieces.empty, "E4": @pieces.empty, "F4": @pieces.empty, "G4": @pieces.empty, "H4": @pieces.empty,
      	"A5": @pieces.empty, "B5": @pieces.empty, "C5": @pieces.empty, "D5": @pieces.empty, "E5": @pieces.empty, "F5": @pieces.empty, "G5": @pieces.empty, "H5": @pieces.empty,
      	"A6": @pieces.empty, "B6": @pieces.empty, "C6": @pieces.empty, "D6": @pieces.empty, "E6": @pieces.empty, "F6": @pieces.empty, "G6": @pieces.empty, "H6": @pieces.empty,
      	"A7": @pieces.bPawn, "B7": @pieces.bPawn, "C7": @pieces.bPawn, "D7": @pieces.bPawn, "E7": @pieces.bPawn, "F7": @pieces.bPawn, "G7": @pieces.bPawn, "H7": @pieces.bPawn,
      	"A8": @pieces.bRook, "B8": @pieces.bKnight, "C8": @pieces.bBishop, "D8": @pieces.bQueen, "E8": @pieces.bKing, "F8": @pieces.bBishop, "G8": @pieces.bKnight, "H8": @pieces.bRook
    	},
      	selectedPiece: -1,
      	availableMoves: [],
		isWhiteTurn: true,
		countOfPlayers: 0,
		viewMode: false,
		players: %{},
    }
  end

  def chessPositionSelected(game, position) do
  	newGameState = getNewGameState(game, position)
  	newGameState = Map.put(newGameState, :countOfPlayers, game.countOfPlayers)
	newGameState = Map.put(newGameState, :viewMode, game.viewMode)
	newGameState = Map.put(newGameState, :players, game.players)
  	newGameState
  end
  
  defp getNewGameState(game, position) do
  	offset = if game.isWhiteTurn == true do
  				0
  			 else
  			 	6
  			 end
  			 
  	currentSelection = if (game.selectedPiece == -1) do
  		game.board[String.to_atom(position)]
  	else
  		game.board[String.to_atom(game.selectedPiece)]
  	end
  	
  	selectedClass = getPieceClass(currentSelection, offset)
  	
  	if game.selectedPiece == -1 do
  		if selectedClass == nil do
  			game
  		else
  			selectedClass.getMoves(game,position)
  		end
  	else
  		if Enum.member?(game.availableMoves, position) == true do
  			selectedClass.playmove(game,position)
  		else
  			currentSelection = game.board[String.to_atom(position)]
		  	selectedClass = getPieceClass(currentSelection, offset)
		  	if (currentSelection < 6 && game.isWhiteTurn == true) do
		  		selectedClass.getMoves(game,position)
		  	else
		  		if (currentSelection < 12 && currentSelection > 5 && game.isWhiteTurn == false) do
		  			selectedClass.getMoves(game,position)
		  		else
		  			%{
  						board: game.board,
      					selectedPiece: -1,
      					availableMoves: [],
						isWhiteTurn: game.isWhiteTurn,
						countOfPlayers: game.countOfPlayers,
						viewMode: game.viewMode
  					}
		  		end
		  	end
  		end
  	end
  end
  
  defp getPieceClass(currentSelection, offset) do
  	if currentSelection == (@pieces.wPawn + offset) do
		Pawn
  	else 
  		if currentSelection == (@pieces.wRook + offset) do
  			Rook
  		else 
  			if currentSelection == (@pieces.wKnight + offset) do
  				Knight
  			else 
  				if currentSelection == (@pieces.wBishop + offset) do
  					Bishop
  				else 
  					if currentSelection == (@pieces.wQueen + offset) do
  						Queen
  					else 
  						if currentSelection == (@pieces.wKing + offset) do
  							King
  						else
  							nil
  						end
  					end
  				end
  			end
  		end
  	end
  end
  
end

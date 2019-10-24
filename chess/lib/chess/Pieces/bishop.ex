defmodule Chess.Bishop do

alias Chess.BoardStatus

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

  def playmove(game,position) do
	IO.inspect("Play move")
  	selectedPiece = game.board[String.to_atom(game.selectedPiece)]
  	tempBoard = Map.put(game.board, String.to_atom(game.selectedPiece), @pieces.empty)
  	newBoard = Map.put(tempBoard, String.to_atom(position), selectedPiece)
  	
  	%{
  		board: newBoard,
      	selectedPiece: -1,
      	availableMoves: [],
      	isWhiteTurn: !game.isWhiteTurn
  	}
  end
  
  def getMoves(game,position) do
  	IO.inspect("Get move")
  	isWhite = isWhiteColor(game,position)
  	  	
  	availableMoves = getTLValidMoves(game, position, [], isWhite) ++ getTRValidMoves(game, position, [], isWhite) ++ getBLValidMoves(game, position, [], isWhite) ++ getBRValidMoves(game, position, [], isWhite)
  	
  	IO.inspect(availableMoves)
  	
  	%{
  		board: game.board,
      	selectedPiece: position,
      	availableMoves: availableMoves,
      	isWhiteTurn: game.isWhiteTurn
  	}
  	
  end
  
  defp isWhiteColor(game, position) do
  	currentSelection = if (game.selectedPiece == -1) do
  		game.board[String.to_atom(position)]
  	else 
  		game.selectedPiece
  	end
  	currentSelection == @pieces.wBishop
  end
  
  defp getTLValidMoves(game, currentPosition, moves, isWhite) do
	characterPosition = String.at(currentPosition,0)
  	{numberPosition, ""} = Integer.parse(String.at(currentPosition,1))
  	<<nextChar::utf8>> = characterPosition
  	newPosition = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition - 1)
  	
  	if Map.has_key?(game.board, String.to_atom(newPosition)) do
  		if game.board[String.to_atom(newPosition)] == 12 do
  			if BoardStatus.isCheckWhenMovingPiece() == false do
  				getTLValidMoves(game, newPosition, moves ++ [newPosition], isWhite)
  			else
  				getTLValidMoves(game, newPosition, moves, isWhite)
  			end
  		else
  			if (isWhite == true && game.board[String.to_atom(newPosition)] < 6) || (isWhite == false && game.board[String.to_atom(newPosition)] > 5) do
  				moves
  			else
  				if BoardStatus.isCheckWhenMovingPiece() == false do
  					moves ++ [newPosition]
  				else
  					moves
  				end
  			end
  		end
  	else
  		moves
  	end
  end
  
  defp getTRValidMoves(game, currentPosition, moves, isWhite) do
  	characterPosition = String.at(currentPosition,0)
  	{numberPosition, ""} = Integer.parse(String.at(currentPosition,1))
  	<<nextChar::utf8>> = characterPosition
  	newPosition = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition - 1)
  	
  	if Map.has_key?(game.board, String.to_atom(newPosition)) do
  		if game.board[String.to_atom(newPosition)] == 12 do
  			if BoardStatus.isCheckWhenMovingPiece() == false do
  				getTRValidMoves(game, newPosition, moves ++ [newPosition], isWhite)
  			else
  				getTRValidMoves(game, newPosition, moves, isWhite)
  			end
  		else
  			if (isWhite == true && game.board[String.to_atom(newPosition)] < 6) || (isWhite == false && game.board[String.to_atom(newPosition)] > 5) do
  				moves
  			else
  				if BoardStatus.isCheckWhenMovingPiece() == false do
  					moves ++ [newPosition]
  				else
  					moves
  				end
  			end
  		end
  	else
  		moves
  	end
  end
  
  defp getBLValidMoves(game, currentPosition, moves, isWhite) do
  	characterPosition = String.at(currentPosition,0)
  	{numberPosition, ""} = Integer.parse(String.at(currentPosition,1))
  	<<nextChar::utf8>> = characterPosition
  	newPosition = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition + 1)
  	
  	if Map.has_key?(game.board, String.to_atom(newPosition)) do
  		if game.board[String.to_atom(newPosition)] == 12 do
  			if BoardStatus.isCheckWhenMovingPiece() == false do
  				getBLValidMoves(game, newPosition, moves ++ [newPosition], isWhite)
  			else
  				getBLValidMoves(game, newPosition, moves, isWhite)
  			end
  		else
  			if (isWhite == true && game.board[String.to_atom(newPosition)] < 6) || (isWhite == false && game.board[String.to_atom(newPosition)] > 5) do
  				moves
  			else
  				if BoardStatus.isCheckWhenMovingPiece() == false do
  					moves ++ [newPosition]
  				else
  					moves
  				end
  			end
  		end
  	else
  		moves
  	end
  end
  
  defp getBRValidMoves(game, currentPosition, moves, isWhite) do
  	characterPosition = String.at(currentPosition,0)
  	{numberPosition, ""} = Integer.parse(String.at(currentPosition,1))
  	<<nextChar::utf8>> = characterPosition
  	newPosition = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition + 1)
  	
  	if Map.has_key?(game.board, String.to_atom(newPosition)) do
  		if game.board[String.to_atom(newPosition)] == 12 do
  			if BoardStatus.isCheckWhenMovingPiece() == false do
  				getBRValidMoves(game, newPosition, moves ++ [newPosition], isWhite)
  			else
  				getBRValidMoves(game, newPosition, moves, isWhite)
  			end
  		else
  			if (isWhite == true && game.board[String.to_atom(newPosition)] < 6) || (isWhite == false && game.board[String.to_atom(newPosition)] > 5) do
  				moves
  			else
  				if BoardStatus.isCheckWhenMovingPiece() == false do
  					moves ++ [newPosition]
  				else
  					moves
  				end
  			end
  		end
  	else
  		moves
  	end
  end
  
end

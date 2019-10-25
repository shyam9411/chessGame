defmodule Chess.Rook do

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
  
  def playmove(game,position,newPosition) do
  	selectedPiece = game.board[String.to_atom(position)]
  	tempBoard = Map.put(game.board, String.to_atom(position), @pieces.empty)
  	newBoard = Map.put(tempBoard, String.to_atom(newPosition), selectedPiece)
  	
  	%{
  		board: newBoard,
      	selectedPiece: -1,
      	availableMoves: [],
      	isWhiteTurn: game.isWhiteTurn
  	}
  end
  
  def getMoves(game,position) do
  	IO.inspect("Get move")
  	isWhite = isWhiteColor(game,position)
  	  	
  	availableMoves = getTValidMoves(game, position, [], isWhite) ++ getRValidMoves(game, position, [], isWhite) ++ getLValidMoves(game, position, [], isWhite) ++ getBValidMoves(game, position, [], isWhite)
  	
  	IO.inspect(availableMoves)
  	
  	%{
  		board: game.board,
      	selectedPiece: position,
      	availableMoves: availableMoves,
      	isWhiteTurn: game.isWhiteTurn
  	}
  	
  end
  
  def getMovesWC(game,position) do
  	isWhite = isWhiteColor(game,position)
  	  	
  	availableMoves = getTValidMovesWC(game, position, [], isWhite) ++ getRValidMovesWC(game, position, [], isWhite) ++ getLValidMovesWC(game, position, [], isWhite) ++ getBValidMovesWC(game, position, [], isWhite)
  	
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
  	currentSelection == @pieces.wRook
  end
  
  defp getLValidMoves(game, currentPosition, moves, isWhite) do
	characterPosition = String.at(currentPosition,0)
  	{numberPosition, ""} = Integer.parse(String.at(currentPosition,1))
  	<<nextChar::utf8>> = characterPosition
  	newPosition = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition)
  	
  	if Map.has_key?(game.board, String.to_atom(newPosition)) do
  		if game.board[String.to_atom(newPosition)] == 12 do
  			if BoardStatus.isCheckWhenMovingPiece(playmove(game,currentPosition,newPosition)) == false do
  				getLValidMoves(game, newPosition, moves ++ [newPosition], isWhite)
  			else
  				getLValidMoves(game, newPosition, moves, isWhite)
  			end
  		else
  			if (isWhite == true && game.board[String.to_atom(newPosition)] < 6) || (isWhite == false && game.board[String.to_atom(newPosition)] > 5) do
  				moves
  			else
  				if BoardStatus.isCheckWhenMovingPiece(playmove(game,currentPosition,newPosition)) == false do
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
  
  defp getRValidMoves(game, currentPosition, moves, isWhite) do
  	characterPosition = String.at(currentPosition,0)
  	{numberPosition, ""} = Integer.parse(String.at(currentPosition,1))
  	<<nextChar::utf8>> = characterPosition
  	newPosition = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition)
  	
  	if Map.has_key?(game.board, String.to_atom(newPosition)) do
  		if game.board[String.to_atom(newPosition)] == 12 do
  			if BoardStatus.isCheckWhenMovingPiece(playmove(game,currentPosition,newPosition)) == false do
  				getRValidMoves(game, newPosition, moves ++ [newPosition], isWhite)
  			else
  				getRValidMoves(game, newPosition, moves, isWhite)
  			end
  		else
  			if (isWhite == true && game.board[String.to_atom(newPosition)] < 6) || (isWhite == false && game.board[String.to_atom(newPosition)] > 5) do
  				moves
  			else
  				if BoardStatus.isCheckWhenMovingPiece(playmove(game,currentPosition,newPosition)) == false do
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
  
  defp getTValidMoves(game, currentPosition, moves, isWhite) do
  	characterPosition = String.at(currentPosition,0)
  	{numberPosition, ""} = Integer.parse(String.at(currentPosition,1))
  	<<nextChar::utf8>> = characterPosition
  	newPosition = List.to_string([nextChar]) <> Integer.to_string(numberPosition - 1)
  	
  	if Map.has_key?(game.board, String.to_atom(newPosition)) do
  		if game.board[String.to_atom(newPosition)] == 12 do
  			if BoardStatus.isCheckWhenMovingPiece(playmove(game,currentPosition,newPosition)) == false do
  				getTValidMoves(game, newPosition, moves ++ [newPosition], isWhite)
  			else
  				getTValidMoves(game, newPosition, moves, isWhite)
  			end
  		else
  			if (isWhite == true && game.board[String.to_atom(newPosition)] < 6) || (isWhite == false && game.board[String.to_atom(newPosition)] > 5) do
  				moves
  			else
  				if BoardStatus.isCheckWhenMovingPiece(playmove(game,currentPosition,newPosition)) == false do
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
  
  defp getBValidMoves(game, currentPosition, moves, isWhite) do
  	characterPosition = String.at(currentPosition,0)
  	{numberPosition, ""} = Integer.parse(String.at(currentPosition,1))
  	<<nextChar::utf8>> = characterPosition
  	newPosition = List.to_string([nextChar]) <> Integer.to_string(numberPosition + 1)
  	
  	if Map.has_key?(game.board, String.to_atom(newPosition)) do
  		if game.board[String.to_atom(newPosition)] == 12 do
  			if BoardStatus.isCheckWhenMovingPiece(playmove(game,currentPosition,newPosition)) == false do
  				getBValidMoves(game, newPosition, moves ++ [newPosition], isWhite)
  			else
  				getBValidMoves(game, newPosition, moves, isWhite)
  			end
  		else
  			if (isWhite == true && game.board[String.to_atom(newPosition)] < 6) || (isWhite == false && game.board[String.to_atom(newPosition)] > 5) do
  				moves
  			else
  				if BoardStatus.isCheckWhenMovingPiece(playmove(game,currentPosition,newPosition)) == false do
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
  
  defp getLValidMovesWC(game, currentPosition, moves, isWhite) do
	characterPosition = String.at(currentPosition,0)
  	{numberPosition, ""} = Integer.parse(String.at(currentPosition,1))
  	<<nextChar::utf8>> = characterPosition
  	newPosition = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition)
  	
  	if Map.has_key?(game.board, String.to_atom(newPosition)) do
  		if game.board[String.to_atom(newPosition)] == 12 do
  			getLValidMovesWC(game, newPosition, moves ++ [newPosition], isWhite)
  		else
  			if (isWhite == true && game.board[String.to_atom(newPosition)] < 6) || (isWhite == false && game.board[String.to_atom(newPosition)] > 5) do
  				moves
  			else
  				moves ++ [newPosition]
  			end
  		end
  	else
  		moves
  	end
  end
  
  defp getRValidMovesWC(game, currentPosition, moves, isWhite) do
  	characterPosition = String.at(currentPosition,0)
  	{numberPosition, ""} = Integer.parse(String.at(currentPosition,1))
  	<<nextChar::utf8>> = characterPosition
  	newPosition = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition)
  	
  	if Map.has_key?(game.board, String.to_atom(newPosition)) do
  		if game.board[String.to_atom(newPosition)] == 12 do
  			getRValidMovesWC(game, newPosition, moves ++ [newPosition], isWhite)
  		else
  			if (isWhite == true && game.board[String.to_atom(newPosition)] < 6) || (isWhite == false && game.board[String.to_atom(newPosition)] > 5) do
  				moves
  			else
  				moves ++ [newPosition]
  			end
  		end
  	else
  		moves
  	end
  end
  
  defp getTValidMovesWC(game, currentPosition, moves, isWhite) do
  	characterPosition = String.at(currentPosition,0)
  	{numberPosition, ""} = Integer.parse(String.at(currentPosition,1))
  	<<nextChar::utf8>> = characterPosition
  	newPosition = List.to_string([nextChar]) <> Integer.to_string(numberPosition - 1)
  	
  	if Map.has_key?(game.board, String.to_atom(newPosition)) do
  		if game.board[String.to_atom(newPosition)] == 12 do
  			getTValidMovesWC(game, newPosition, moves ++ [newPosition], isWhite)
  		else
  			if (isWhite == true && game.board[String.to_atom(newPosition)] < 6) || (isWhite == false && game.board[String.to_atom(newPosition)] > 5) do
  				moves
  			else
  				moves ++ [newPosition]
  			end
  		end
  	else
  		moves
  	end
  end
  
  defp getBValidMovesWC(game, currentPosition, moves, isWhite) do
  	characterPosition = String.at(currentPosition,0)
  	{numberPosition, ""} = Integer.parse(String.at(currentPosition,1))
  	<<nextChar::utf8>> = characterPosition
  	newPosition = List.to_string([nextChar]) <> Integer.to_string(numberPosition + 1)
  	
  	if Map.has_key?(game.board, String.to_atom(newPosition)) do
  		if game.board[String.to_atom(newPosition)] == 12 do
  			getBValidMovesWC(game, newPosition, moves ++ [newPosition], isWhite)
  		else
  			if (isWhite == true && game.board[String.to_atom(newPosition)] < 6) || (isWhite == false && game.board[String.to_atom(newPosition)] > 5) do
  				moves
  			else
  				moves ++ [newPosition]
  			end
  		end
  	else
  		moves
  	end
  end
  
end

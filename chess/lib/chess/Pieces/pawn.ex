defmodule Chess.Pawn do

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
  	  	
  	if game.isWhiteTurn == true do
  		getMovesForWhitePiece(game, position)
  	else
  		getMovesForBlackPiece(game, position)
  	end
  end
  
  defp isWhiteColor(game, position) do
  	currentSelection = if (game.selectedPiece == -1) do
  		game.board[String.to_atom(position)]
  	else 
  		game.selectedPiece
  	end
  	currentSelection == @pieces.wPawn
  end
  
  defp getMovesForWhitePiece(game, position) do
  	characterPosition = String.at(position,0)
  	{numberPosition, ""} = Integer.parse(String.at(position,1))
  	<<nextChar::utf8>> = characterPosition
  	diagonalMove1 = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition + 1)
  	diagonalMove2 = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition + 1)
  	
  	availableMoves = 
  		if BoardStatus.isCheckWhenMovingPiece() == true do
  			[]
  		else
  			if numberPosition == 2 do
  				newPosition = characterPosition <> Integer.to_string(numberPosition + 2)
  				if game.board[String.to_atom(newPosition)] == @pieces.empty do
  					[newPosition]
  				else
  					[]
  				end
  			else
  				[]
  			end ++
  			if numberPosition != 8 do
  				newPosition = characterPosition <> Integer.to_string(numberPosition + 1)
  				if game.board[String.to_atom(newPosition)] == @pieces.empty do
  					[newPosition]
  				else
  					[]
  				end
	  		else
	  			[]
  			end++
  			if game.board[String.to_atom(diagonalMove1)] > 5 && game.board[String.to_atom(diagonalMove1)] < 12 do
  				[diagonalMove1]
  			else
  				[]
  			end ++
  			if game.board[String.to_atom(diagonalMove2)] > 5 && game.board[String.to_atom(diagonalMove2)] < 12 do
  				[diagonalMove2]
  			else
  				[]
  			end
  		end
  		
  		IO.inspect(availableMoves)
  		
  	%{
  		board: game.board,
      	selectedPiece: position,
      	availableMoves: availableMoves,
      	isWhiteTurn: game.isWhiteTurn
  	}
  end
  
  defp getMovesForBlackPiece(game, position) do
  	characterPosition = String.at(position,0)
  	{numberPosition, ""} = Integer.parse(String.at(position,1))
  	<<nextChar::utf8>> = characterPosition
  	diagonalMove1 = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition - 1)
  	diagonalMove2 = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition - 1)
  	
  	availableMoves = 
	  	if BoardStatus.isCheckWhenMovingPiece() == true do
  			[]
  		else
  			if numberPosition == 7 do
  				newPosition = characterPosition <> Integer.to_string(numberPosition - 2)
  				if game.board[String.to_atom(newPosition)] == @pieces.empty do
  					[newPosition]
  				else
  					[]
  				end
  			else
  				[]
  			end ++
  			if numberPosition != 1 do
  				newPosition = characterPosition <> Integer.to_string(numberPosition - 1)
  				if game.board[String.to_atom(newPosition)] == @pieces.empty do
  					[newPosition]
  				else
  					[]
  				end
	  		else
	  			[]
  			end++
  			if game.board[String.to_atom(diagonalMove1)] >= 0 && game.board[String.to_atom(diagonalMove1)] < 6 do
  				[diagonalMove1]
  			else
  				[]
  			end ++
  			if game.board[String.to_atom(diagonalMove2)] >= 0 && game.board[String.to_atom(diagonalMove2)] < 6 do
  				[diagonalMove2]
  			else
  				[]
  			end
  		end
  		
  		IO.inspect(availableMoves)
  		
  	%{
  		board: game.board,
      	selectedPiece: position,
      	availableMoves: availableMoves,
      	isWhiteTurn: game.isWhiteTurn
  	}
  end
  
end

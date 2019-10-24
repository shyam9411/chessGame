defmodule Chess.King do

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
  	currentSelection == @pieces.wKing
  end
  
  defp getMovesForWhitePiece(game, position) do
  	characterPosition = String.at(position,0)
  	{numberPosition, ""} = Integer.parse(String.at(position,1))
  	<<nextChar::utf8>> = characterPosition
  	
  	ul = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition - 1)
  	u = List.to_string([nextChar]) <> Integer.to_string(numberPosition - 1)
  	ur = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition - 1)
  	r = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition)
  	br = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition + 1)
  	b = List.to_string([nextChar]) <> Integer.to_string(numberPosition + 1)
  	bl = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition + 1)
  	l = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition)
  	
  	availableMoves =
  		if Map.has_key?(game.board, String.to_atom(ul)) && game.board[String.to_atom(ul)] > 5 && BoardStatus.isKingAtCheckAtPosition() == false do
  			[ul]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(u)) && game.board[String.to_atom(u)] > 5 && BoardStatus.isKingAtCheckAtPosition() == false do
  			[u]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ur)) && game.board[String.to_atom(ur)] > 5 && BoardStatus.isKingAtCheckAtPosition() == false do
  			[ur]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(r)) && game.board[String.to_atom(r)] > 5 && BoardStatus.isKingAtCheckAtPosition() == false do
  			[r]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(br)) && game.board[String.to_atom(br)] > 5 && BoardStatus.isKingAtCheckAtPosition() == false do
  			[br]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(b)) && game.board[String.to_atom(b)] > 5 && BoardStatus.isKingAtCheckAtPosition() == false do
  			[b]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(bl)) && game.board[String.to_atom(bl)] > 5 && BoardStatus.isKingAtCheckAtPosition() == false do
  			[bl]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(l)) && game.board[String.to_atom(l)] > 5 && BoardStatus.isKingAtCheckAtPosition() == false do
  			[l]
  		else 
  			[]
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
  	
  	ul = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition - 1)
  	u = List.to_string([nextChar]) <> Integer.to_string(numberPosition - 1)
  	ur = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition - 1)
  	r = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition)
  	br = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition + 1)
  	b = List.to_string([nextChar]) <> Integer.to_string(numberPosition + 1)	
  	bl = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition + 1)
  	l = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition)
  	
  	availableMoves =
  		if Map.has_key?(game.board, String.to_atom(ul)) && (game.board[String.to_atom(ul)] <= 5 || game.board[String.to_atom(ul)] == 12) && BoardStatus.isKingAtCheckAtPosition() == false do
  			[ul]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(u)) && (game.board[String.to_atom(u)] <= 5 || game.board[String.to_atom(u)] == 12) && BoardStatus.isKingAtCheckAtPosition() == false do
  			[u]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ur)) && (game.board[String.to_atom(ur)] <= 5 || game.board[String.to_atom(ur)] == 12) && BoardStatus.isKingAtCheckAtPosition() == false do
  			[ur]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(r)) && (game.board[String.to_atom(r)] <= 5 || game.board[String.to_atom(r)] == 12) && BoardStatus.isKingAtCheckAtPosition() == false do
  			[r]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(br)) && (game.board[String.to_atom(br)] <= 5 || game.board[String.to_atom(br)] == 12) && BoardStatus.isKingAtCheckAtPosition() == false do
  			[br]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(b)) && (game.board[String.to_atom(b)] <= 5 || game.board[String.to_atom(b)] == 12) && BoardStatus.isKingAtCheckAtPosition() == false do
  			[b]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(bl)) && (game.board[String.to_atom(bl)] <= 5 || game.board[String.to_atom(bl)] == 12) && BoardStatus.isKingAtCheckAtPosition() == false do
  			[bl]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(l)) && (game.board[String.to_atom(l)] <= 5 || game.board[String.to_atom(l)] == 12) && BoardStatus.isKingAtCheckAtPosition() == false do
  			[l]
  		else 
  			[]
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

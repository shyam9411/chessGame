defmodule Chess.Knight do

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
  	  	
  	if game.isWhiteTurn == true do
  		getMovesForWhitePiece(game, position)
  	else
  		getMovesForBlackPiece(game, position)
  	end
  end
  
  def getMovesWC(game,position) do
  	isWhite = isWhiteColor(game,position)
  	  	
  	if game.isWhiteTurn == true do
  		getMovesForWhitePieceWC(game, position)
  	else
  		getMovesForBlackPieceWC(game, position)
  	end
  end
  
  defp isWhiteColor(game, position) do
  	currentSelection = if (game.selectedPiece == -1) do
  		game.board[String.to_atom(position)]
  	else 
  		game.selectedPiece
  	end
  	currentSelection == @pieces.wKnight
  end
  
  defp getMovesForWhitePiece(game, position) do
  	characterPosition = String.at(position,0)
  	{numberPosition, ""} = Integer.parse(String.at(position,1))
  	<<nextChar::utf8>> = characterPosition
  	
  	ul1 = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition - 2)
  	ul2 = List.to_string([nextChar - 2]) <> Integer.to_string(numberPosition - 1)
  	ur1 = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition - 2)
  	ur2 = List.to_string([nextChar + 2]) <> Integer.to_string(numberPosition - 1)
  	bl1 = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition + 2)
  	bl2 = List.to_string([nextChar - 2]) <> Integer.to_string(numberPosition + 1)
  	br1 = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition + 2)
  	br2 = List.to_string([nextChar + 2]) <> Integer.to_string(numberPosition + 1)
  	
  	availableMoves =
  		if Map.has_key?(game.board, String.to_atom(ul1)) && game.board[String.to_atom(ul1)] > 5 && BoardStatus.isCheckWhenMovingPiece(playmove(game,position,ul1)) == false do
  			[ul1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ul2)) && game.board[String.to_atom(ul2)] > 5 && BoardStatus.isCheckWhenMovingPiece(playmove(game,position,ul2)) == false do
  			[ul2]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ur1)) && game.board[String.to_atom(ur1)] > 5 && BoardStatus.isCheckWhenMovingPiece(playmove(game,position,ur1)) == false do
  			[ur1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ur2)) && game.board[String.to_atom(ur2)] > 5 && BoardStatus.isCheckWhenMovingPiece(playmove(game,position,ur2)) == false do
  			[ur2]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(bl1)) && game.board[String.to_atom(bl1)] > 5 && BoardStatus.isCheckWhenMovingPiece(playmove(game,position,bl1)) == false do
  			[bl1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(bl2)) && game.board[String.to_atom(bl2)] > 5 && BoardStatus.isCheckWhenMovingPiece(playmove(game,position,bl2)) == false do
  			[bl2]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(br1)) && game.board[String.to_atom(br1)] > 5 && BoardStatus.isCheckWhenMovingPiece(br1) == false do
  			[br1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(br2)) && game.board[String.to_atom(br2)] > 5 && BoardStatus.isCheckWhenMovingPiece(br2) == false do
  			[br2]
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
  	
  	ul1 = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition - 2)
  	ul2 = List.to_string([nextChar - 2]) <> Integer.to_string(numberPosition - 1)
  	ur1 = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition - 2)
  	ur2 = List.to_string([nextChar + 2]) <> Integer.to_string(numberPosition - 1)
  	bl1 = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition + 2)
  	bl2 = List.to_string([nextChar - 2]) <> Integer.to_string(numberPosition + 1)
  	br1 = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition + 2)
  	br2 = List.to_string([nextChar + 2]) <> Integer.to_string(numberPosition + 1)
  	
  	availableMoves =
  		if Map.has_key?(game.board, String.to_atom(ul1)) && (game.board[String.to_atom(ul1)] <= 5 || game.board[String.to_atom(ul1)] == 12) && BoardStatus.isCheckWhenMovingPiece(playmove(game,position,ul1)) == false do
  			[ul1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ul2)) && (game.board[String.to_atom(ul2)] <= 5 || game.board[String.to_atom(ul2)] == 12) && BoardStatus.isCheckWhenMovingPiece(playmove(game,position,ul2)) == false do
  			[ul2]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ur1)) && (game.board[String.to_atom(ur1)] <= 5 || game.board[String.to_atom(ur1)] == 12) && BoardStatus.isCheckWhenMovingPiece(playmove(game,position,ur1)) == false do
  			[ur1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ur2)) && (game.board[String.to_atom(ur2)] <= 5 || game.board[String.to_atom(ur2)] == 12) && BoardStatus.isCheckWhenMovingPiece(playmove(game,position,ur2)) == false do
  			[ur2]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(bl1)) && (game.board[String.to_atom(bl1)] <= 5 || game.board[String.to_atom(bl1)] == 12) && BoardStatus.isCheckWhenMovingPiece(playmove(game,position,bl1)) == false do
  			[bl1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(bl2)) && (game.board[String.to_atom(bl2)] <= 5 || game.board[String.to_atom(bl2)] == 12) && BoardStatus.isCheckWhenMovingPiece(playmove(game,position,bl2)) == false do
  			[bl2]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(br1)) && (game.board[String.to_atom(br1)] <= 5 || game.board[String.to_atom(br1)] == 12) && BoardStatus.isCheckWhenMovingPiece(br1) == false do
  			[br1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(br2)) && (game.board[String.to_atom(br2)] <= 5 || game.board[String.to_atom(br2)] == 12) && BoardStatus.isCheckWhenMovingPiece(br2) == false do
  			[br2]
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
  
  defp getMovesForWhitePieceWC(game, position) do
  	characterPosition = String.at(position,0)
  	{numberPosition, ""} = Integer.parse(String.at(position,1))
  	<<nextChar::utf8>> = characterPosition
  	
  	ul1 = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition - 2)
  	ul2 = List.to_string([nextChar - 2]) <> Integer.to_string(numberPosition - 1)
  	ur1 = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition - 2)
  	ur2 = List.to_string([nextChar + 2]) <> Integer.to_string(numberPosition - 1)
  	bl1 = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition + 2)
  	bl2 = List.to_string([nextChar - 2]) <> Integer.to_string(numberPosition + 1)
  	br1 = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition + 2)
  	br2 = List.to_string([nextChar + 2]) <> Integer.to_string(numberPosition + 1)
  	
  	availableMoves =
  		if Map.has_key?(game.board, String.to_atom(ul1)) && game.board[String.to_atom(ul1)] > 5 do
  			[ul1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ul2)) && game.board[String.to_atom(ul2)] > 5 do
  			[ul2]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ur1)) && game.board[String.to_atom(ur1)] > 5 do
  			[ur1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ur2)) && game.board[String.to_atom(ur2)] > 5 do
  			[ur2]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(bl1)) && game.board[String.to_atom(bl1)] > 5 do
  			[bl1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(bl2)) && game.board[String.to_atom(bl2)] > 5 do
  			[bl2]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(br1)) && game.board[String.to_atom(br1)] > 5 do
  			[br1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(br2)) && game.board[String.to_atom(br2)] > 5 do
  			[br2]
  		else 
  			[]
  		end
  		
  	%{
  		board: game.board,
      	selectedPiece: position,
      	availableMoves: availableMoves,
      	isWhiteTurn: game.isWhiteTurn
  	}
  end
  
  defp getMovesForBlackPieceWC(game, position) do
  	characterPosition = String.at(position,0)
  	{numberPosition, ""} = Integer.parse(String.at(position,1))
  	<<nextChar::utf8>> = characterPosition
  	
  	ul1 = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition - 2)
  	ul2 = List.to_string([nextChar - 2]) <> Integer.to_string(numberPosition - 1)
  	ur1 = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition - 2)
  	ur2 = List.to_string([nextChar + 2]) <> Integer.to_string(numberPosition - 1)
  	bl1 = List.to_string([nextChar - 1]) <> Integer.to_string(numberPosition + 2)
  	bl2 = List.to_string([nextChar - 2]) <> Integer.to_string(numberPosition + 1)
  	br1 = List.to_string([nextChar + 1]) <> Integer.to_string(numberPosition + 2)
  	br2 = List.to_string([nextChar + 2]) <> Integer.to_string(numberPosition + 1)
  	
  	availableMoves =
  		if Map.has_key?(game.board, String.to_atom(ul1)) && (game.board[String.to_atom(ul1)] <= 5 || game.board[String.to_atom(ul1)] == 12) do
  			[ul1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ul2)) && (game.board[String.to_atom(ul2)] <= 5 || game.board[String.to_atom(ul2)] == 12) do
  			[ul2]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ur1)) && (game.board[String.to_atom(ur1)] <= 5 || game.board[String.to_atom(ur1)] == 12) do
  			[ur1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(ur2)) && (game.board[String.to_atom(ur2)] <= 5 || game.board[String.to_atom(ur2)] == 12) do
  			[ur2]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(bl1)) && (game.board[String.to_atom(bl1)] <= 5 || game.board[String.to_atom(bl1)] == 12) do
  			[bl1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(bl2)) && (game.board[String.to_atom(bl2)] <= 5 || game.board[String.to_atom(bl2)] == 12) do
  			[bl2]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(br1)) && (game.board[String.to_atom(br1)] <= 5 || game.board[String.to_atom(br1)] == 12) do
  			[br1]
  		else 
  			[]
  		end ++ if Map.has_key?(game.board, String.to_atom(br2)) && (game.board[String.to_atom(br2)] <= 5 || game.board[String.to_atom(br2)] == 12) do
  			[br2]
  		else 
  			[]
  		end
  	
  	%{
  		board: game.board,
      	selectedPiece: position,
      	availableMoves: availableMoves,
      	isWhiteTurn: game.isWhiteTurn
  	}
  end
  
end

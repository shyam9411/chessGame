defmodule Chess.BoardStatus do
  
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
  
  def isCheckMate(game) do
  	{players,offset} = {getWhitePieces(game),0}
  	containsMap1 = Enum.map(players, fn x -> length(getPieceClass(game.board[x],offset).getMovesWC(game,Atom.to_string(x)).availableMoves) end)
  	count = Enum.sum(containsMap1)
  	if count > 0 do
  		{players,offset} = {getBlackPieces(game),6}
  		containsMap1 = Enum.map(players, fn x -> length(getPieceClass(game.board[x],offset).getMovesWC(game,Atom.to_string(x)).availableMoves) end)
  		count = Enum.sum(containsMap1)
  		
  		if count > 0 do
  			0
  		else
  			-1
  		end
  	else
  		1
  	end
  end
  
  def isCheck(game) do
  	kingPosition = Atom.to_string(getWhiteKingPosition(game))
  	{players,offset} = {getBlackPieces(game),6}
  	containsMap1 = Enum.map(players, fn x -> Enum.member?(getPieceClass(game.board[x],offset).getMovesWC(game,Atom.to_string(x)).availableMoves, kingPosition) end)
  	
  	kingPosition = Atom.to_string(getBlackKingPosition(game))
  	{players,offset} = {getWhitePieces(game),0}
  	containsMap2 = Enum.map(players, fn x -> Enum.member?(getPieceClass(game.board[x],offset).getMovesWC(game,Atom.to_string(x)).availableMoves, kingPosition) end)
    
    Enum.reduce(containsMap1, fn x, acc -> x or acc end) || Enum.reduce(containsMap2, fn x, acc -> x or acc end)
  end
  
  def isCheckWhenMovingPiece(game) do
  	kingPosition = if game.isWhiteTurn == true do
  		Atom.to_string(getWhiteKingPosition(game))
  	else
  		Atom.to_string(getBlackKingPosition(game))
  	end
  	
  	{players,offset} = if game.isWhiteTurn == true do
    	{getBlackPieces(game),6}
    else
    	{getWhitePieces(game),0}
    end
    
  	containsMap = Enum.map(players, fn x -> Enum.member?(getPieceClass(game.board[x],offset).getMovesWC(game,Atom.to_string(x)).availableMoves, kingPosition) end)
    
    Enum.reduce(containsMap, fn x, acc -> x or acc end)
  end
  
  def isKingAtCheckAtPosition(game,position,newPosition) do
    isWhite = isWhiteColor(game,position)
    {players,offset} = if isWhite == true do
    	{getBlackPieces(game),6}
    else
    	{getWhitePieces(game),0}
    end
    
    containsMap = Enum.map(players, fn x -> Enum.member?(getPieceClass(game.board[x],offset).getMovesWC(game,Atom.to_string(x)).availableMoves, newPosition) end)
    
    Enum.reduce(containsMap, fn x, acc -> x or acc end)
  end
  
  defp isWhiteColor(game, position) do
  	currentSelection = if (game.selectedPiece == -1) do
  		game.board[String.to_atom(position)]
  	else 
  		game.selectedPiece
  	end
  	currentSelection == @pieces.wKing
  end
  
  defp getWhitePieces(game) do
  	Enum.filter(Map.keys(game.board), fn x -> game.board[x] < 6 end)
  end
  
  defp getBlackPieces(game) do
  	Enum.filter(Map.keys(game.board), fn x -> game.board[x] > 5 && game.board[x] < 12 end)
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
  
  defp getWhiteKingPosition(game) do
  	List.first(Enum.filter(Map.keys(game.board), fn x -> game.board[x] == 0 end))
  end
  
  defp getBlackKingPosition(game) do
  	List.first(Enum.filter(Map.keys(game.board), fn x -> game.board[x] == 6 end))
  end
end

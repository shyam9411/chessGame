defmodule Chess.Game do

  alias Chess.Pawn

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
      cutPieces: []
    }
  end

  def client_view(game) do
    game
  end

  def chessPieceSelected(game, position) do
    selectedPiece = game.board.position
    if selectedPiece == @pieces.bPawn do
    
    else
    
    end
	game
  end
  
  def chessPositionSelected(game, position) do
	game
  end
  
end

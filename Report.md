#	     CHESS – Multiplayer Game
	     
	    
Authors: Shyam Kumar & Tarun Kumar

#Introduction and Game Description:
This document is a game design report for a 2 Player Chess game. Players will be able to take turns and make their move in the game. The game follows all the default rules of the chess game and the game will end once either of the player lands in a checkmate or if no more moves are possible. More details on the rules and description on the game can be found in http://www.chesscoachonline.com/chess-articles/chess-rules.

The game initially requires the user to enter his name and the name of the game. The first person entering the game room is the player 1
and will be assigned the white pieces and the second player will be assigned black pieces. We also provide another feature where other will be able to view and spectate the game. Any user who tries to enter the game apart from the first 2 users will be in the spectate mode. If a user closes the game and wants to join the game he can join by entering the same user name and game name he used and continue the game from where he/she left.

While playing the game a user will be able to select a chess piece and will be able to view the list possible moves that is available for the selected piece. This is provided in such a way that it follows all the chess rules and the provided moves does not provide those moves that might lead in check. The available moves are shown in such a way that the cells are highlighted in a black border and the selected cell is having yellow border.

#UI Design:
The main screen of the game contains 2 text field that asks the user to enter user name and game name and a submit button. Upon selecting the submit button the user is redirected into the game room with the first 2 players as the one who will have access to the board and make their moves. The other players who join the game will be in the view mode and the board status will be visible to them. 

The board consists of 8x8 grid with alternating colors. The game will start with the play pieces at the top of the board and black pieces at the bottom of the board. The initial game state is fetched from the server which has the details of pieces and their positions. The images are sent from the server and hence any change to the pieces can be done in the server which would change all the instances of the game. Upon selecting a position in the board, the selected piece is highlighted and the list available moves for the selected piece is shown to the user. The list of available moves is computed and sent from the server. When any move in the player results in a "Check" the users are intimated and hence the user can make the necessary move.

#UI to Server Protocol:
The UI code would correspond with the state in server using the following message:

Join - Triggered when a player intends to join a specific game room. Here the channel is established by using the topic being the game name, and an additional param of player name being sent to the server. The server utilizes the topic to pick the board appropriately and use the additional param to determine its players. Only 2 players are allowed, and rest of such join requests are considered as view mode to the current board.

Broadcast - This is a message that a client often triggers to the server. This is a sync call to ensure the change in state incurred by a client has been synced to every player of the board (let the player be an active participant or a viewer). There is no specific response being sent to the user who had initiated this message. Instead the message is broadcasted to the channel. Any endpoint connected to the channel would receive this message if registered for the event of broadcast.

Reset - This message is triggered when the game winner has been determined and a new game has to be instantiated in the server for the same game board. The new board which gets created is in turn broadcasted instead of unicasting the new board to the intended user. This way, the entire crowd of the user base gets to see the newer board of the game upon completion.

Position Selected - This message is communicated between a client to a server when a user plays a game. It is a message to determine if the move intended by a user is valid. The server takes the position and emits feasible moves for the current piece and in case the move is determined to be valid, it returns a newer status to the user. Here the server doesn't broadcast the message to other users, as it must ensure the recipient is available before proceeding further in the game. The broadcast is picked from the client code to the server which then redirects the newer state to other users.


#Data structures on server:
The game state which includes details on the name of the players, viewers, board arrangement, who is to play next, status on check or check mate of the current game and also status on the next possible moves. All of these are stored as a part of a custom map object structed which captures all the mentioned details. The game logic is abstracted as a part of certain classes likely: 

boardStatus - The main board structure is maintained as a map with the positions as key and the value that is present in the location as value. 
selectedPiece - The selected piece that will be moved in the next move.
availableMoves - The list of available moves that the selected piece can move to.
isWhiteTurn - Boolean value that saves if the current move to be played is by white.
countOfPlayers - Number of players that are currently in the game.
viewMode - The viewMode of the current player, i.e., whether the player can make a move or can just view the game.
players - Map containing the list of players with the color of piece they will be controlling.
isCheck - Boolean value determining if the current game has a check.
isCheckMate - Integer value that states if the game is complete, i.e., if player 1 has won or if player 2 has won or if the game is still proceeding.

#Implementation of game rules:
The main logic for the chess game starts from the game.ex file. Once a position has been selected in the chess board, we first check if the another piece has already been selected. If no other piece has been selected, we compute the available moves for the selected piece and return it to the game via the socket. Before that we check if the piece selected is a part of the valid selection, i.e., the piece is from the set of available chess pieces. There are different classes for each for the chess pieces namely - Pawn, Rook, Knight, Bishop, Queen, King. Each of these class has a method that computes the list of available moves for the selected piece. This is done by fetching all the possible moves that is possible for the selected piece and the then filtered such that a valid move is possible. Each of the pieces has their set of game logic since each piece has their own type of movement possible.

Once the available moves are calculated and sent back to the game, the player will now know which moves he/she has that can be used in the next move. When the user selects a chess position in the next move, we now check if the selected position is a part of the available move that was calculated in the previous operation. If it is not a part of the available moves, then we reset the selected piece and return the new game state. If the selected position is a part of the available moves then we make the piece to move to the new position and update game state in the appropriate way.

Once the move is made, we then check if the opposition king has encountered a check so that that can displayed to the user. Also, we check if the game has ended by checking if the opposition has any valid moves such that the king does not have a check. So, after every move the player can know if the game has ended or not.


#Challenges and Solutions:
Establishing the socket connection and providing a channel that allows 2 players moves was one of the major challenges that we faced when developing the game. We had an issue where we had to restrict the player moves when it is the players turn. Also, the game state must be updated when a 2nd player joins the game so that the player 1 can start playing his game. This was solved using broadcast connection that will send a message when a new player joins the game. This will also be triggered whenever the other player makes a move so that the game state is updated for all the payers playing and watching the game.

Another challenge we faced was the designing the game logic. We faced an issue where we didn't know as to how to abstract each of the functionalities of the pieces. We later split the functions where each piece logic was in a different class. By doing so we were to get the available moves for each of the pieces which was used to determining the check and checkmate conditions.

Importing the assets from the elixir was also another problem we faced. We initially had the assets imported from the JS file but then later made the assets to be loaded from the elixir code. This was done so that any change in the image assets can be done in the server side and this will update a live game session.

Future Enhancements:
As a next step to the game, we can support timers. A player will have a fixed time to make all his moves. The person whose timer first expires will lose the game. Another enhancement that we thought of providing to game is have authentication for the user where the user will have password along with the user name. Another feature that we thought of providing is live chat, where the players and the people who are watching the game will be able to interact with the players. So, anyone who is inside the game room will be able to view and converse with each other anonymously or non-anonymously. A feature that we see that could be useful to all users is to have themes and different mode so that the user customizes the color of the chess board and the type of pieces that he wants the board to have. This will also help color blind people to differentiate between different pieces and positions with some texture applied to all pieces of white and another type applied to all pieces of black.

#Resources:
http://www.chesscoachonline.com/chess-articles/chess-rules : Link that contains the links of the game
https://opengameart.org/content/chess-pieces-and-a-board : Assets download from
Elixir code references:
https://hexdocs.pm/elixir/List.html 
https://hexdocs.pm/elixir/Map.html
https://hexdocs.pm/elixir/Enum.html

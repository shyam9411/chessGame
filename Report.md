#	     CHESS
	     
	    
Authors: Shyam Kumar & Tarun Kumar

#Introduction and Game Description:
This document is a game design report for a 2 Player Chess game. Players will be able to take turns and make their move in the game. The game follows all the default rules of the chess game and the game will end once either of the player lands in a checkmate or if no more moves are possible. More details on the rules and description on the game can be found in http://www.chesscoachonline.com/chess-articles/chess-rules.

The game initially requires the user to enter his name and the name of the game. The first person entering the game room is the player 1
and will be assigned the white pieces and the second player will be assigned black pieces. We also provide another feature where other will be able to view and spectate the game. Any user who tries to enter the game apart from the first 2 users will be in the spectate mode. If a user closes the game and wants to join the game he can join by entering the same user name and game name he used and continue the game from where he/she left.

While playing the game a user will be able to select a chess piece and will be able to view the list possible moves that is available for the selected piece. This is provided in such a way that it follows all the chess rules and the provided moves does not provide those moves that might lead in check. The available moves are shown in such a way that the cells are highlighted in a black border and the selected cell is having yellow border.

#UI Design:
The main screen of the game contains 2 text field that asks the user to enter user name and game name and a submit button. Upon selecting the submit button the user is redirected into the game room with the first 2 players as the one who will have access to the board and make their moves. The other players who join the game will be in the view mode and the board status will be visible to them. 

The board consisits of 8x8 grid with alternating colors. The game will start with the play pieces at the top of the board and black pieces at the bottom of the board. The initial game state is fetched from the server which has the details of pieces and their positions. The images are sent from the server and ence any change to the pieces can be done in the server which would change all the instances of the game. Upon selecting a position in the board the selected piece is highlighted and the list available moves for the selected piece is shown to the user. The list of avaiable moves is computed and sent from the server. When any move in the player results in a "Check" the users are intimated and hence the user can make the necessary move.

#UI to Server Protocol:


#Data structures on server:
The main board structure is maintained as a map with the positions as key and the value that is present in the location as value. Apart from this we store the list of players that are playing the game along with which color they are playing for. The map also contains a boolean vale which maintains whose turn it is to play the game.

#Implementation of game rules:
Pieces - logic
Get game moves
Make moves
Check logic
Check check and check mate

#Challenges and Solutions:
Finding the basic logic for the game
Establishing connection to the server
Broadcasting the message to server so that one player board is blocked when it is other players turn

#Resources:
http://www.chesscoachonline.com/chess-articles/chess-rules : Link that contains the links of the game
: Assets download from
: Elixir code reference

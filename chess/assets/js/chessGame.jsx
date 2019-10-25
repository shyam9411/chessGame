import React from 'react';
import ReactDOM from 'react-dom';

export default function game_init(root, channel) {
  ReactDOM.render(<ChessGame channel={channel} />, root);
}

const boardConstants = [
	wKing,
    wQueen,
    wBishop,
    wKnight,
    wRook,
    wPawn,
    bKing,
    bQueen,
    bBishop,
    bKnight,
    bRook,
    bPawn,
    "empty"
];

class ChessGame extends React.Component {
	constructor(props) {
        super(props);
        this.channel = props.channel;

		this.state = {
			board: {},
			selectedPiece: -1,
			availableMoves: [],
			isWhiteTurn: true,
			countOfPlayers: 0,
			viewMode: false,
			players: {}
        };
        
        this.channel.join()
           .receive("ok", resp => {this.updateState.bind(this); this.channel.push("broadcast", {});})
		   .receive("error", resp => { console.log("Unable to join", resp) });

		this.channel.on("broadcast", this.updateState.bind(this));

	}

	updateState({game}) {
		console.log(game);
		this.setState(game);
	}

	/**
	 * Method to handle the click events on the DOM elements. We validate the click for a match if its corresponding match has been found by the user. Else the click would be considered as a new tile open.
	 * @param tileId determines the id of the tile from which the event was triggered
	 */
	handleClick(tileId) {
		if(this.state.viewMode || (this.state.players[player_name] !== "w" && this.state.isWhiteTurn) 
					|| (this.state.players[player_name] !== "b" && !this.state.isWhiteTurn))
			return;

		let array = {0:"A", 1:"B", 2:"C", 3:"D", 4:"E", 5:"F", 6:"G", 7:"H"};
		let value = Math.floor(tileId / 8) + 1;
		
		console.log(array[tileId % 8] + value);
		
		this.channel.push("positionSelected", {position: array[tileId % 8] + "" + (value)})
			.receive("correct",this.updateState.bind(this));
		
		this.channel.push("broadcast", {});
	}

	render() {
		let titleEle = <div className="titleContainer">Chess Game<br></br><h2>Player Name: {player_name}</h2></div>;
		let viewModeText = <h2>Currently in View Mode</h2>

		let gameTiles = [];
		let counter = 0;
		let alternate = false;
		for (let i = 0; i < 64; i++) {
			if (i % 8 == 0) {
				counter = alternate ? 0 : 1;
				alternate = !alternate;
			}

			let secondaryColor = (counter % 2 == 0) ? "green" : "white";
			if (this.state.availableMoves.indexOf(String.fromCharCode((i % 8) + 65) + "" + (Math.floor(i / 8)+ 1)) !== -1)
				secondaryColor += " black";
			else if (this.state.selectedPiece === String.fromCharCode((i % 8) + 65) + "" + (Math.floor(i / 8)+ 1))
				secondaryColor += " darkorange";

			gameTiles.push(<div className={"tiles " + secondaryColor} id={i} onClick={() => this.handleClick(i)}>
				{
					boardConstants[this.state.board[String.fromCharCode((i % 8) + 65) + "" + (Math.floor(i / 8)+ 1)]] !== "empty" ?
						<img src={boardConstants[this.state.board[String.fromCharCode((i % 8) + 65) + "" + (Math.floor(i / 8)+ 1)]]} alt=""></img> : null

				}
				</div>);
				++counter;
		}
		
		return (
			<div className="tileContainer">
				{titleEle}
				{gameTiles}
				{this.state.viewMode ? viewModeText : null}
			</div>
		);
  	}
}


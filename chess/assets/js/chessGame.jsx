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
			isWhiteTurn: true
        };
        
		this.resetGame = this.resetGame.bind(this);
        this.channel.join()
           .receive("ok", this.onJoin.bind(this))
		   .receive("error", resp => { console.log("Unable to join", resp) });
		   
		console.log(boardConstants);
	}

    onJoin({game}) {
    	console.log(game);
        this.setState(game);
    }

	/**
	 * Method to reset the game state to initial state. Also we randomise the tiles again as the game has been reset.
	 */
	resetGame() {
		this.channel.push("reset")
            .receive("ok", this.onUpdate.bind(this));	
	}
	
	updateBoard({game}) {
		this.setState(game);
	}

	/**
	 * Method to handle the click events on the DOM elements. We validate the click for a match if its corresponding match has been found by the user. Else the click would be considered as a new tile open.
	 * @param tileId determines the id of the tile from which the event was triggered
	 */
	handleClick(tileId) {
		let array = {0:"A", 1:"B", 2:"C", 3:"D", 4:"E", 5:"F", 6:"G", 7:"H"};
		let value = Math.floor(tileId / 8) + 1;
		
		console.log(array[tileId % 8] + value);
		
		this.channel.push("positionSelected", {position: array[tileId % 8] + "" + (value)})
			.receive("correct",this.updateBoard.bind(this));
	}

	render() {
		let resetButton = <button className="reset" onClick={this.resetGame}>Reset Game</button>;
		let titleEle = <div className="titleContainer">Chess Game</div>;

		let gameTiles = [];
		let counter = 0;
		let alternate = false;
		for (let i = 0; i < 64; i++) {
			if (i % 8 == 0) {
				counter = alternate ? 0 : 1;
				alternate = !alternate;
			}

			gameTiles.push(<div className={"tiles " + ((counter % 2 == 0) ? "brown" : "gold")} id={i} onClick={() => this.handleClick(i)}>
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
				{resetButton}
			</div>
		);
  	}
}


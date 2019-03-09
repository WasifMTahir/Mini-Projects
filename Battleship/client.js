const socket = io()

const delay = secs => new Promise(resolve => setTimeout(resolve, 1000*secs))

const shipsize = {
	'aircraft_carrier': 5,
	'battleship': 4,
	'cruiser': 3,
	'destroyer': 2,
	'submarine': 1
}
const state = {}

const setState = updates => {
	Object.assign(state, updates)
	ReactDOM.render(React.createElement('div', null, state.msg), 
		document.getElementById('root'))
}

setState({msg: 'BattleShip'})

let boxInfo = []
var hi;
for (hi=0; hi<100; hi++)
{
	boxInfo[hi] = hi.toString()
}

const makeGrid = () => {
	let rows = 10
	let cols = 10
	let grid = []
	var i;
	for (i=0; i<rows; i++)
	{
		for (j=0; j<cols; j++)
		{
			grid.push(React.createElement(
				'BUTTON',
				{
					id: (i*10+j),
					className: 'box',
					onClick: () => makeMove() 
				}, boxInfo[i*10+j]
			))
		}
		grid.push(React.createElement('div', {id: (i*10+j+1)}))
		console.log(i*10+j+1)
	}
	return React.createElement('div', {}, grid)
}
ReactDOM.render(makeGrid(), document.getElementById('root'))

const makeMove = index => {
	//Couldnt reference index of button clicked so used random number sorry
	index = Math.ceil(100*Math.random(1, 100))
	console.log(index)
	if (index%10<6)
	{
		for (var l=0; l<100; l++){
			boxInfo[l] = l
		}
		for (var k=0; k<5; k++){
			boxInfo[index+k] = 'Ship'
		}
	}
	else
	{
		alert("Ship Wont Fit Here Sorry")
		return
	}
	ReactDOM.render(makeGrid(), document.getElementById('root'))
}

const dropDown = () => {
	let menu = []
	menu.push(React.createElement('option', {}, 'aircraft_carrier'))
	menu.push(React.createElement('option', {}, 'battleship'))
	menu.push(React.createElement('option', {}, 'cruiser'))
	menu.push(React.createElement('option', {}, 'destroyer'))
	menu.push(React.createElement('option', {}, 'submarine'))
	return React.createElement('div', {}, menu)
}
ReactDOM.render(React.createElement('select', {id: 'selectMenu'}), document.getElementById('101'))
ReactDOM.render(dropDown(), document.getElementById('selectMenu'))
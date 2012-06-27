
Strict

Import wdw.framework.state.statebasedgame



'summary: A game state template.
Class State Abstract
	
	Private
	
	'summary: Game holding this state.
	Field _game:StateBasedGame
	
	'summary: ID of this State.
	Field _id:Int
	
	Public
	
	
	
	'summary: A place to put any state setup.
	Method Enter:Void() Abstract

	'summary: A place to put any state teardown.
	Method Leave:Void() Abstract

	
	Method Update:Void() Abstract

	Method Render:Void() Abstract
	

	
	Method Id:Void(id:Int) Property
		_id = id
	End
	
	Method Id:Int() Property
		Return _id
	End
	
	
	Method Game:Void(g:StateBasedGame) Property
		_game = g
	End
		
	Method Game:StateBasedGame() Property
		Return _game
	End

End
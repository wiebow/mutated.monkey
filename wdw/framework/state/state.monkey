
Strict

Import wdw.framework.game


'summary: A game state template.
Class State Abstract
	
	Private
	
	'Game holding this state.
	Field _game:Game
	
	'ID of this State.
	Field _id:Int
	
	Public
	
	
	'summary: A place for user state setup.
	Method Enter:Void() Abstract

	'summary: A place for user state teardown.
	Method Leave:Void() Abstract
	
	Method Update:Void() Abstract

	Method Render:Void() Abstract
	

	Method Id:Void(id:Int) Property
		_id = id
	End
	
	
	Method Id:Int() Property
		Return _id
	End
	

	Method Game:Void(g:Game) Property
		_game = g
	End
	
		
	Method Game:Game() Property
		Return _game
	End

End
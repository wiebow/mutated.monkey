
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
	
	
	#rem
	summary: User hook to perform state startup logic.
	This method is called when the state is entered, before the fadein.
	#END	
	Method Enter:Void() Abstract

	#rem
	summary: User hook to perform state teardown logic.
	This method is called when the state is left, after the fadeout.
	#END
	Method Leave:Void() Abstract
	
	
	'summary: User hook to perform state update logic.	
	Method Update:Void() Abstract

	'summary: User hook to perform state render code.	
	Method Render:Void() Abstract
	

	Method Id:Void(id:Int) Property
		_id = id
	End
	
	
	'summary: Returns the ID of this state.
	Method Id:Int() Property
		Return _id
	End
	

	Method Game:Void(g:Game) Property
		_game = g
	End
	
	
	'summary: Returns the game owning this state.
	Method Game:Game() Property
		Return _game
	End

End
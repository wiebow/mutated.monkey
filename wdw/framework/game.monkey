
Strict


'summary:The main game interface every game needs to implement.
Interface Game
	
	'summary: Load game resources etc here.
	Method Init:Void()
	
	'summary: Update the game logic here.
	Method Update:Void()
	
	'summary: Render the game here.
	Method Render:Void()
	
	'summary: Returns true if the game should be closed.
	Method CloseRequested:Bool()
	
	'summary: Creates a new game.
	Method New(title:String)
	
	'summary: Returns the title of this game.
	Method Title:String() Property
	
End

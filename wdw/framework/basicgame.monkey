
Strict

Import game



'summary: Basic implementation of a game.
Class BasicGame Implements Game Abstract

	Private
	
	'summary: The title of this game.
	Field _title:String = "Powered by wdw.framework."
	
	'summary: Engine uses this to determine if the game should shut down.	
	Field _closerequested:Bool
			
	Public
	
	
	
	'Called when the game is created. Override this if needed.
	Method Init:Void()
	End
	
	
	
	'override this method.
	Method Update:Void()
	End
	

	'override this method.
	Method Render:Void()
	End
		
	
	
	'summary: Returns the game title.		
	Method Title:String() Property
		Return _title
	End
	
	
	
	'summary: Sets the game title.
	Method Title:Void(title:String) Property
		_title = title
	End
	
	
	
	'summary: Sets the close requested flag.
	Method CloseRequested:Void(b:Bool) Property
		_closerequested = b
	End
	
	
	
	'summary: Returns true if the game needs to be closed.
	Method CloseRequested:Bool() Property
		Return _closerequested
	End

End class
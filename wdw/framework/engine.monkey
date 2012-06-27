
Strict

Import mojo
Import wdw.framework.engine
Import wdw.framework.game


'summary: 2D Framework engine Class.
Class Engine extends App

	Private
	
	'summary: Engine update rate.
	Field _rate:Int
	
	'summary: The current game.
	Field _game:Game
	
	'summary: Engine is paused when this is true.
	Field _paused:Bool
	
	'summary: Engine is running when this is true.
	Field _running:Bool
	
	
	Public
	
	
	
	'summary: Creates a new engine.
	Method New(g:Game, updateRate:Int = 60)
		_game = g
		_rate = updateRate
	End Method
	

	
	'summary: Inits the game and starts the engine.
	Method OnCreate:Int()
		If _game = Null Then Error("No Game present!")
		_game.Init()
		
		SetUpdateRate(_rate)
		Running = True
		Paused = False
		Return 0
	End Method

	
	
	'summary: Updates the current game.
	Method OnUpdate:Int()
		If Running = True
			If Paused = False Then _game.Update()
		End
		Return 0
	End Method
	
	
	
	'summary: Renders the current game.
	Method OnRender:int()
		_game.Render()	
		Return 0	
	End Method
	
	
	
	'summary: Called when the engine is suspended.	
	Method OnSuspend:Int()
		Running = False
		Return 0
	End
	
	
	
	'summary: Called when the engine is resuming.
	Method OnResume:Int()
		Running = True
		Return 0
	End
	
	
	
	'summary: Called when the app is loading resources.
	Method OnLoading:Int()
		Return 0
	End

	
	
	'summary: Returns the engine pause mode.
	Method Paused:Bool() Property
		Return _paused
	End
	
	
	
	'summary: Sets the engine pause mode.
	Method Paused:Void(value:Bool) Property
		_paused = value
	End
	
	
	
	'summary: Returns the engine running variable value.
	Method Running:Bool() Property
		Return _running
	End
	
		
	
	'summary: Sets the engine running variable value.
	Method Running:Void(value:Bool) Property
		_running = value
	End
	
	
	
	'summary: Returns the current game in the engine.	
	Method Game:Game() Property
		Return _game
	End
	
	
	
	'summary: Sets the current game.	
	Method Game:Void(g:Game) Property
		_game = g
	End
	
	
	
	'summary: Returns the engine update rate.
	Method Rate:Int() Property
		Return _rate
	End
	
	
	
	'summary: Sets the engine update rate.	
	Method Rate:Void(rate:Int) Property
		_rate = rate
	End
		
End


Strict

Import wdw.tools.bag
Import state
Import state.transition.emptytransition


'summary: A state based game, with transitions.
Class Game

	Private
	
	'The title of this game.
	Field _title:String = "Powered by wdw.framework!"
	
	'Engine uses this to determine if the game should shut down.	
	Field _closerequested:Bool
	
	'Collection of game states, by index.
	Field _gameStates:= New Bag<State>
		
	'The current game state.
	Field _currentState:State
	
	'The state we will be going to.
	Field _nextState:State
	
	'The transtion to play when leaving this state.
	Field _leaveTransition:Transition
	
	'The transition to play when entering this state.
	Field _enterTransition:Transition
		
	Public
	
	
	'Called when the game is created. Override this if needed.
	Method Init:Void()
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
	
	
	'Updates the game.
	Method Update:Void()
	
		If _leaveTransition
			_leaveTransition.Update()
			If _leaveTransition.IsComplete()
				_currentState.Leave()
				_currentState = _nextState
				_nextState = Null
				_leaveTransition = Null
				_currentState.Enter()
				If _enterTransition Then _enterTransition.Init()
			Else
				Return
			End
		End
		
		If _enterTransition
			_enterTransition.Update()
			If _enterTransition.IsComplete()
				_enterTransition = Null
			Else
				Return
			End
		End
		_currentState.Update()
	End
		
	
	'renders the current game state.
	Method Render:Void()	
		_currentState.Render()
				
		If _leaveTransition
			_leaveTransition.Render()
		ElseIf _enterTransition
			_enterTransition.Render()
		End
	End
	
		
	'Enter a gamestate with the specified transitions.
	Method EnterState:Void(id:Int, enter:Transition = Null, leave:Transition = Null)
		If Not enter Then enter = New EmptyTransition
		If Not leave Then leave = New EmptyTransition
		
		_enterTransition = enter
		_leaveTransition = leave
		
		_nextState = GetStateByID(id)
		If Not _nextState Then Error("Cannot find state with ID: " + id)
		
		_leaveTransition.Init()
	End
		
	
	'summary: Adds a state to this game. First state added becomes the current state.
	Method AddGameState:Void(s:State, id:Int)
		_gameStates.Set(id, s)
		s.Game = Self
		s.Id = id
		If Not _currentState Then _currentState = s
	End
	
		
	'summary: Returns the ID of the current state.
	Method GetCurrentStateID:Int()
		Return _currentState.Id
	End
		
	
	'summary: Returns game state by specified ID.
	Method GetStateByID:State(id:Int)
		Return _gameStates.Get(id)
	End
	
End
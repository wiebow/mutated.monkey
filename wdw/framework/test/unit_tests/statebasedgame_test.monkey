
'unit tests for wdw.framework.state.statebasedgame
Strict

Import wdw.unittest
Import wdw.framework.state
Import wdw.framework.state.statebasedgame
Import wdw.framework.state.transition.fadeintransition
Import wdw.framework.state.transition.emptytransition



Class BasicGameTest Extends Test

	Field g:StateBasedGameMock
	
	
	Method doBefore:Void()
		g = New StateBasedGameMock
	End
	
	Method doAfter:Void()
		g = Null
	End
	
	
	Method ConstructorTest:Void()
		assertNotNull(g, "")
	End	
	
	
	Method PropertyTitleTest:Void()
		g.Title = "test"
		assertEquals("test", g.Title, "")
	End
	
	
	Method AddStateTest:Void()
		Local s := New StateMock
		g.AddGameState(s, 1)
		'should be the current state
		assertEquals(1, g.GetCurrentStateID(), "")
	End
	
	
	Method GetStateTest:Void()
		Local s := New StateMock
		g.AddGameState(s, 1)
		assertSame(s, g.GetStateByID(1), "")
	End
	
	
	Method EnterStateTest:Void()
		Local s1 := New StateMock
		g.AddGameState(s1, 1)
		
		Local s2 := new StateMock
		g.AddGameState(s2, 2)
		
		g.EnterState(2, New FadeInTransition)
		
		'private fields to check! to do.
							
	End
End



Class StateBasedGameMock Extends StateBasedGame

	Method Initialize:Void()
	End Method
	
	Method Render:Void()
	End Method

	Method Update:Void()
	End Method
End


Class StateMock extends State
	
	Method Enter:Void()
	End
	
	Method Leave:Void()
	End
	
	Method Update:Void()
	End

	Method Render:Void()
	End
End


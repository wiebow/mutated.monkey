
'unit tests for wdw.framework.engine

Strict

Import wdw.unittest
Import wdw.framework.engine

Class EngineTest Extends Test

	Field e:Engine
	
	
	Method doBefore:Void()
		e = New Engine(new GameMock)
	End
	
	Method doAfter:Void()
		e = Null
	End
	
	
	Method ConstructorTest:Void()
		assertNotNull(e, "")
		
		'call this as we're not starting the app
		e.OnCreate()
		assertTrue(e.Running, "not running")
		assertFalse(e.Paused, "is paused")
		assertNotNull(e.Game, "no game")
'		assertNotNull(e.Timer(),"no timer")
'		assertTrue( e.Vsync(), "no vsync")
		
	End	
	
	
	Method PropertyGameTest:Void()
		Local g:GameMock = new GameMock
		e.Game = g
		assertSame(g, e.Game, "no game set!")
	End
	
	
	Method RunningTest:Void()
		e.OnCreate()
		assertTrue(e.Running, "not running")
		e.Running = False
		assertFalse(e.Running(), "running!")
	End
	
	
	Method RateTest:Void()
		e.OnCreate()
		assertEquals(60, e.Rate, "")
	End
	
	

End Class



Class GameMock Implements Game


	Method Init:Void()
	End

	Method Render:Void()
	End
	
	Method Update:Void()
	End
	
	Method CloseRequested:Bool()
		Return False
	End

	Method Title:String() Property
		Return "Test"
	End
	
End
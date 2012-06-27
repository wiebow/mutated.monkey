
'unit tests for wdw.framework.basicgame

Strict

Import wdw.unittest
Import wdw.framework.basicgame

Class BasicGameTest Extends Test

	Field g:BasicGameMock
	
	
	Method doBefore:Void()
		g = New BasicGameMock
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

End Class



Class BasicGameMock Extends BasicGame

	Method Initialize:Void()
	End Method
	
	Method Render:Void()
	End Method

	Method Update:Void()
	End Method
	
End
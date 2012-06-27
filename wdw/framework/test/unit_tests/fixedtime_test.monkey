
'unit tests for wdw.framework.fixedtime

Strict

Import wdw.unittest
Import wdw.framework.fixedtime

Class FixedTimeTest Extends Test

	Field f:FixedTime
	
	
	Method doBefore:Void()
		f = New FixedTime
	End
	
	Method doAfter:Void()
		f = Null
	End
	
	
	Method ConstructorTest:Void()
		assertNotNull(f, "")
	End

End Class
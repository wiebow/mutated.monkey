
Strict

#REFLECTION_FILTER="simple_test|reflection|wdw.unittest*"

Import wdw.unittest

Function Main:Int()
	Local t:TestSuite = New TestSuite
	t.Run()
	Return 0
End


Class MyClassTest Extends TestBase
	
	Field m:MyClass

	
	Method dothisBefore:Void()
		'we do this before each unit test
		m = New MyClass
	End
	
	Method dothisAfter:Void()
		'we do this after each unit test
		m = Null
	End
	
	
	Method constructorTest:Void()
		Self.assertNotNull(m)
	End	
		
	Method constructortwoTest:Void()
		Self.assertNull(m)
	End
	
End


Class MyClass
	
	Private	
	Field simplefield:Int
	Public	
	
	Method Simplefield:Int(i:Int) Property
		simplefield = i
		Return 0
	End
	
	Method Simplefield:Int() Property
		Return simplefield
	End
End
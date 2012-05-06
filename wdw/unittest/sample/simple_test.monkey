
Strict

#REFLECTION_FILTER="simple_test|reflection|wdw.unittest*"

Import wdw.unittest


Function Main:Int()
	Local t:= New TestSuite
	t.Run()
	Return 0
End


'my unit tests for MyClass.
Class MyClassTest Extends Test
	
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
		assertNotNull(m, "This will pass.")
	End	
	
	'this test will fail
	Method constructortwoTest:Void()
		assertNull(m, "This will fail.")
	End
	
End


'the class we want to test.
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
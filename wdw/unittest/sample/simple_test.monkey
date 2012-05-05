
Strict

#REFLECTION_FILTER="simple_test|reflection|wdw.unittest*"

Import wdw.unittest


Function Main:Int()
	Local t:= New TestSuite
	t.Run()
	Return 0
End


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
	
	
	'this test will pass
	Method constructorTest:Void()
		assertNotNull(m)
	End	
	
	'this test will fail
	Method constructortwoTest:Void()
		assertNull(m)
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
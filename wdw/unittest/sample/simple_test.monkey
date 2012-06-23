
Strict

'set reflection filter.
'using *_test will add all files using that suffix
#REFLECTION_FILTER="*_test|reflection|wdw.unittest*"

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
	

	'the tests	
	Method constructorTest:Void()
		assertNotNull(m, "")
	End	
	
	
	
	Method constructortwoTest:Void()
		assertNull(m, "this will fail")
	End
	
	
	
	Method BoolTest:Void()
		m.simplebool = True		
		assertTrue(m.simplebool, "")
		assertFalse(m.simplebool, "this will fail")		
	End Method
	
	
	
	Method IntEqualsTest:Void()
		m.simpleint = 10
		assertEquals(m.simpleint, 10, "")
		assertEquals(m.simpleint, 12, "this will fail")
	End Method
	
	
	
	Method FloatEqualsTest:Void()
		m.simplefloat = 10.1
		assertEquals(m.simplefloat, 10.1, "")
		assertEquals(m.simplefloat, 10.2, "this will fail")
	End Method
	
	
	
	Method NotSameTest:Void()
		Local m2:MyClass = New MyClass
		assertNotSame(m2, m, "")
		assertSame(m2, m, "this will fail")	
	End Method
		
End


'the class we want to test.
Class MyClass
	
	Field simpleint:Int
	Field simplestring:string
	Field simplebool:Bool
	Field simplefloat:Float
		
End
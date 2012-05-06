
Strict

Import reflection
Import testfunction
Import test

#Rem
summary: A test suite defines the fixture to run multiple tests.
#End
Class TestSuite Extends Assert

	'summary: instances of derived test classes go here.
	Field tests := New List <Object>
		
	'summary: the current unit test.
	Field currentTest:TestFunction

		
	#Rem
	summary: Runs the suite of tests.
	The test suite will stop when an error occurs in a unit test.
	#end
	Method Run:Void()
		
		AddTests()
		
		Print("~n* Starting testsuite containing " + (tests.Count()-1) + " tests.~n")
		
		For Local testClass := EachIn tests
			
			Local thisClass := Test(testClass)
			If Not thisClass Then Error("no class")

			Local size:Int = thisClass.tests.Count()
			Local count:Int = 0
			Local doBefore:Bool = False
			Local doAfter:Bool = False
			
			For Local t:TestFunction = eachin thisClass.tests
			
				Print("- " + t.name)
			
				If count = 0 Then doBefore = True
				If count = size - 1 Then doAfter = True
				PerformTest(t, doBefore, doAfter)
				count += 1
				
			Next
		Next

		Print("~n* Test suite complete.")
	
	End Method
	
	
	
	'summary: Runs the specified test function.
	Method PerformTest:Void(t:TestFunction, first:Int, last:Int)

		currentTest = t
		Local c:= Test(t.instance)		

		'first unit test in this class test?
		If first
			If c.beforeClass Then c.beforeClass.Invoke(t.instance, [])
		End
		
		'run the Before method
		If Test(t.instance).before
			c.before.Invoke(t.instance, [])
		End
		
		'run the unit test.
		'program will halt in debug mode if a test fails.
		t.test.Invoke(t.instance, [])
				
		'run the After method.
		If c.after
			c.after.Invoke(t.instance, [])
		End
		
		'last unit test in this class test?
		If first
			If c.afterClass Then c.afterClass.Invoke(t.instance, [])
		End
	End
	
	
	'summary: Adds all classes derived from Test to the suite.
	Method AddTests:Void()
	
		For Local cl:= eachin GetClasses()
		
			'weed out the non test classes
			If Not cl.Name().EndsWith("Test") Then Continue

			If cl.ExtendsClass(GetClass("Test"))

				'create instance of this class and add it to the tests list				
				Local o:= cl.NewInstance()
				tests.AddLast(o)
				
				For Local me:= eachin cl.GetMethods(True)
					
					'creates a testfunction
					'the function will hold a reference to the test method
					'and the test class.
					'the function is added to the tests list in the test class itself
					If me.Name().EndsWith("Test")
						Add(o, me)
					End

					If me.Name().EndsWith("Before")
						Local f:FieldInfo = cl.GetField("before")						
						f.SetValue(o, me)
					End
					
					If me.Name().EndsWith("After")
						Local f:FieldInfo = cl.GetField("after")
						f.SetValue(o, me)
					End
					
					If me.Name().EndsWith("BeforeClass")
						Local f:FieldInfo = cl.GetField("beforeClass")
						f.SetValue(o, me)
					End
					
					If me.Name().EndsWith("AfterClass")
						Local f:FieldInfo = cl.GetField("afterclass")
						f.SetValue(o, me)
					End		
				Next
			End
		Next
	End Method
	
		
	'summary: Adds a unittest function to specified instance.
	Method Add:TestFunction(instance:Object, f:MethodInfo )
		Local t := New TestFunction
		t.name = "" + GetClass(instance).Name() + "." + f.Name()
		t.instance = instance
		t.test = f
		Test(instance).tests.AddLast(t)
		Return t
	End Method
	
End


Strict

Import mojo
Import reflection
Import testfunction
Import test
Import exceptions



#Rem
summary: A test suite defines the fixture to run multiple tests.
#End
Class TestSuite Extends Assert

	Field isError:Bool
	Field isFail:Bool

	'instances of derived test classes go here.
	Field tests:= New List<Object>
		
	Field errors:= New List<TestFunction>
	Field failures:= New List<TestFunction>
	
	Field testCount:Int
		
	'the current unit test.
	Field currentTest:TestFunction

		
	#Rem
	summary: Runs the suite of tests.
	#end
	Method Run:Void()
		AddTests()
		
		Local message:String = "Starting testsuite containing " + (tests.Count()-1) + " test"
		If tests.Count()-1 > 1 Then message+="s"
		Print(message)
		
		For Local testClass := EachIn tests
			
			'try downcast the extended test class.
			Local thisClass := Test(testClass)
			If Not thisClass Then Error("Error: No class")

			Local size:Int = thisClass.tests.Count()
			Local count:Int = 1
			Local first:Bool = False
			Local last:Bool = False
			
			'run the unit tests in this class			
			For Local t:TestFunction = eachin thisClass.tests
				first = False
				last = False			
				If count = 1 Then first = True
				If count = size Then last = True
				
				PerformTest(t, first, last)
				count += 1
			Next
			
		Next
		
		'lets print the summary.
		Local f:Int = failures.Count()
		Local e:Int = errors.Count()
		
		If f>0 Or e>0
		
			If f > 0 Then
				Local formatted:String = "~nThere "
				If f <> 1 Then
					formatted += "were " + f + " failures:"
				Else
					formatted += "was 1 failure:"
				End If
				Print(formatted)
				
				Local count:Int = 1
				For Local t:= EachIn failures
					Print( count + ") " + t.name)
					Print( "   " + t.reason)
					Print("")
					count+=1
				Next
			End If
			
			If e > 0 Then
				Local formatted:String = "~nThere "
				If e <> 1 Then
					formatted += "were " + e + " errors:"
				Else
					formatted += "was 1 error:"
				End If
				Print(formatted)
				
				Local count:Int = 1
				For Local t:= EachIn errors
					Print( count + ") " + t.name)
					Print( "   " + t.reason)
					Print("")
					count+=1
				Next
				
			End If
			
			Print("~nFAILURES!!")
			Print("Tests run: " + tests.Count() + ", failures: " + f + ", errors: " + e)
			
		Else
			Local formatted:String = "OK (" + tests.Count() + " test"
			If tests.Count() > 1 Then formatted += "s)" Else formatted += ")"
			Print(formatted)			
		End If
			
	End Method
	
	
	'Runs the specified test function.
	Method PerformTest:Void(t:TestFunction, first:Int, last:Int)
		
		isFail = False
		isError = False	

		currentTest = t
		
		Local c:= Test(t.instance)
		
		If first
			Try
				'run any user class setup
				If c.beforeClass Then c.beforeClass.Invoke(t.instance, [])
			Catch ex:AssertionErrorException
				isError = True
				t.reason = " Exception in 'BeforeClass' method - " + ex.ToString()
			End Try	
		End If
		
		
		'run any user test setup
		Try
			If c.before Then c.before.Invoke(t.instance, [])
		Catch ex:AssertionErrorException
			isError = True
			t.reason =  " Exception in 'Before' method - " + ex.ToString()
		End Try

		
		'run the unit test
		If Not isError
			Try
				t.test.Invoke(t.instance, [])
				
			Catch ex:AssertionFailedException
				isFail = True
				t.reason = ex.ToString()
			Catch ex:AssertionErrorException
				isError = True
				t.reason = " Exception - " + ex.ToString()
			End Try
		EndIf 

		
		'run any user test teardown
		Try
			If c.after Then c.after.Invoke(t.instance, [])
		Catch ex:AssertionErrorException
			isError = True
			t.reason =  " Exception in 'After' method - " + ex.ToString()
		End Try

		
		'run any user class teardown
		If last
			Try
				If c.afterClass Then c.afterClass.Invoke(t.instance, [])
			Catch ex:AssertionErrorException
				isError = True
				t.reason = " Exception in 'AfterClass' method - " + ex.ToString()
			End Try	
		End If
	
		
		'print feedback on this unit test		
		If Not isFail
			If Not isError
				Print(currentTest.name + ": Pass")
			Else
				errors.AddLast(currentTest)
				Print(currentTest.name + ": Error")
			End If
		Else
			failures.AddLast(currentTest)
			Print(currentTest.name + ": Fail")
		End If

	End Method
		
	
	'Adds all classes derived from Test to the suite.
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
	
		
	'Adds a unittest function to specified instance.
	Method Add:TestFunction(instance:Object, f:MethodInfo )
		Local t := New TestFunction
		t.name = "" + GetClass(instance).Name() + "." + f.Name()
		t.instance = instance
		t.test = f
		Test(instance).tests.AddLast(t)
		Return t
	End Method
	
End

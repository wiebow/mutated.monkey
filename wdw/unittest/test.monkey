
Strict

#REFLECTION_FILTER+="reflection|wdw.unittest*"

Import reflection
Import testfunction
Import assert

#rem
summary: A test defines a set of test methods to test.
Extend [b]TestBase[/b] to define your own tests. You [b]MUST[/b] end the extended class name with 'Test', otherwise your test is not found.

End a method name with [i]Before[/i] and initialize any variables/data in that method.
End a method name with [i]After[/i] to release any permanent resources you allocated in the setup.
End a method name with [i]BeforeClass[/i] to initialize variables/data you need for the class test.
End a method name with [i]AfterClass[/i] to released any permanent resources you allocated in the setup.
For each test method you want to run, end the name with [i]Test[/i].

Any methods not using this naming scheme are ignored.
#end
Class Test Extends Assert

	Field startTime:Int
	Field endTime:int

	'Unit tests for this test class.
	Field tests:= New List<TestFunction>
	
	'Current unit test.
	Field currentTest:TestFunction
	
	'Failed unit tests.
'	Field failedTests:= New List<TestFunction>
	
	'Current unit test counter.
	Field testCount:Int = 0
	
	'Method to run before each unit test.
	Field before:MethodInfo
	
	'Method to run after each unit test.
	Field after:MethodInfo
	
	'Method to run when starting tests for this class.
	Field beforeClass:MethodInfo
	
	' Method to run when ending tests for this class.
	Field afterClass:MethodInfo
	
End
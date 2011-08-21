
Strict

Import test

#rem
	summary: Testsuite which runs all registered tests.
#end
Class TestSuite

	Private
	
	'summary: list of tests to perform
	Field tests:List<Test>
	
	Field numErrors:Int
	Field numFails:Int

	Public
	
	
	Method New()
		tests = New List<Test>	
	End
		
	
	
	'summary: adds a test to this suite.
	Method RegisterTest:Void(t:Test)
		if tests.Contains(t) = False
			tests.AddLast(t)
		EndIf
	End
	
		
		
	'summary: runs all registered tests and outputs results.
	Method Run:Void()
	
		Print( "Starting Test Suite..."	)
	
		For Local t:= eachin tests
			t.Run()		
		Next
	End 

End
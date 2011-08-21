
#rem
	header: Monkey Unit Test module. Free to use and adapt for your own stuff.
#end

#rem
	footer: (C) 2011, Wiebo de Wit
#end

Strict

Import unit

#rem
	summary: This class is a container for unit tests.
	It is [b]abstract[/b] and must be extended for your test scenario.	
#end
Class Test Abstract

	Private
	
	'summary: Name of this test.
	Field testName:String	

	'summary: A list containing registered unit tests.
	Field units:List<Unit> = New List<Unit>
	
	Public

	#rem
		summary: Optional to override to fit your test scenario.
		This method is called before each unit test.
	#end
	Method SetUp:Void()
	End
	
	#rem
		summary: Optional to override to fit your test scenario.
		This method is called after each unit test.
	#end
	Method TearDown:Void()
	End
	
		
	
	'summary: Runs all registered unit tests.
	Method Run:Int()
	
		Print( "-Starting Test '" + testName + "' containing " + units.Count() + " unit tests." )

		Local runnedTests:Int = 0
		Local testResults:String = ""
		Local currentStatus:String
		
		For Local u:= eachin units
			SetUp()
			u.Run()
			TearDown()
		Next
				
		'show test results
		' ..
	End
	
	
	'summary: Retrieves the name of this test.
	Method TestName:String() Property
		Return testName
	End
	
	
	'summary: Sets the name of this test.
	Method TestName:Void( n:String ) Property
		testName = n
	End

		
	'summary: Registers a unit test to this test.
	Method RegisterUnitTest:Void(u:Unit)
		units.AddLast(u)
		u.RegisterOwner( Self )
	End

End
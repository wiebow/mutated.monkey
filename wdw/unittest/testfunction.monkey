
Strict

Import reflection

Class TestFunction

	'class.name of the test method.
	Field name:String
	
	'Holds the method to call for this unit test.
	Field test:MethodInfo
	
	'Reason for failing this test.
	Field reason:String = ""
	
	'Your derived test class.
	Field instance:Object
End

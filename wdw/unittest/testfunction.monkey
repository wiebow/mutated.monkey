
Strict

Import reflection


#rem
summary: Unit test definition.
#end 
Class TestFunction

	'summary: class.name of the test method.
	Field name:String
	
	'summary: Holds the method to call for this unit test.
	Field test:MethodInfo
	
	'summary: Reason for failing this test.
	Field reason:String = ""
	
	'summary: Your derived test class.
	Field instance:Object
End

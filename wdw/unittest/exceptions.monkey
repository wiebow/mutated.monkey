

'summary: Thrown when an assertion fails.
Class AssertionFailedException Extends Throwable

	'summary: text explaining why the assertion failed.
	Field message:String

	
	
	'summary: Constructor.
	Function Create:AssertionFailedException(message:String)
		Local this:= New AssertionFailedException
		this.message = message
		Return this
	End Function
	
	
	'summary: Returns fail reason string.
	Method ToString:String()
		Return message
	End Method
	
End Class


'summary: Thrown when an assertion error has occured.
Class AssertionErrorException extends Throwable

	'summary: text explaining why the error occured.
	Field message:String
	
	
	'summary: Constructor.
	Function Create:AssertionErrorException(message:String)
		Local this:= New AssertionErrorException
		this.message = message
		Return this
	End Function
	
	
	'summary: Returns error string.
	Method ToString:String()
		Return message
	End Method
	
End Class
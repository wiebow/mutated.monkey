
Strict

Import test

#rem
summary: A set of assert methods.
A message is printed when an assertion fails.
A runtime error is also created when debug is enabled.
#end
Class Assert

	'summary: Creates an error message and halts the program when in debug mode.
	Method Fail:Void(message:string)
		Print("! Failed: " + message)
		
		#If CONFIG = "DEBUG"
			Error("! Failed: " + message)
		#End
	End Method

	
		
	'summary: Asserts that a condition is true.
	Method assertTrue:Bool(b:Bool, message:String)
		If b = False
			Fail("assertTrue() : " + message)
			Return False
		EndIf
		Return true
	End
	
	
	
	'summary: Asserts that a condition is false.
	Method assertFalse:Bool(b:Bool, message:String)
		if b = True
			Fail("assertFalse() : " + message)
			Return False
		End
		Return True
	End	
	
	

	'summary: Asserts that two objects are equal.
	Method assertEquals:Bool(expected:String, actual:String, message:String)
		If expected = actual Then Return True
		
		Fail("assertEquals() failed. Expected: " + expected + ", actual: " + actual + ". " + message)
		Return False
	End

	
	
	'summary: Asserts that two ints are equal.
	Method assertEquals:Bool(expected:Int, actual:Int, message:String)
		If expected = actual Then Return True
		
		Fail("assertEquals() failed. Expected: " + expected + ", actual: " + actual + ". " + message)
		Return False
	End
	
	
	
	'summary: Asserts that two floats are equal.
	Method assertEquals:Bool(expected:Float, actual:Float, message:String)
		If expected = actual Then Return True
		
		Fail("assertEquals() failed. Expected: " + expected + ", actual: " + actual + ". " + message)
		Return False
	End
	
	
	
	'summary: Asserts that an object is not null.
	Method assertNotNull:Bool(obj:Object, message:String)
		If Not obj
			Fail("assertNotNull() failed. " + message)
			Return False
		End
		Return True
	End
	
	
	
	'summary: Asserts that an object is null.
	Method assertNull:Bool(obj:Object, message:String)
		If obj
			Fail("assertNull() failed. " + message)
			Return False
		End
		Return True
	End
	
	
	
	'summary: Asserts that two objects refer to the same object.
	Method assertSame:Bool(expected:Object, actual:Object, message:String)
		If expected = actual Then Return True
		Fail("assertSame() failed. " + message)
		Return False
	End
	
	
	
	'summary: Asserts that two objects refer different objects.
	Method assertNotSame:Bool(expected:Object, actual:Object, message:String)
		If expected = actual
			Fail("assertNotSame() failed. " + message)
			Return False
		End
		Return True
	End
	
End Class
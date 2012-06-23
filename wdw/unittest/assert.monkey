
Strict

Import test
Import exceptions

#rem
summary: A set of assert methods.
#end
Class Assert


		
	'summary: Asserts that a condition is true.
	Method assertTrue:Void(b:Bool, message:String)
		If b = False Then Fail("assertTrue() : " + message)			
	End
	
	
	
	'summary: Asserts that a condition is false.
	Method assertFalse:Void(b:Bool, message:String)
		If b = True Then Fail("assertFalse() : " + message)
	End
	
	

	'summary: Asserts that two objects are equal.
	Method assertEquals:Void(expected:String, actual:String, message:String)
		If expected = actual Then Return
		Fail("assertEquals() : expected:<" + expected + "> but was:<" + actual + "> " + message)
	End

	
	
	'summary: Asserts that two ints are equal.
	Method assertEquals:Void(expected:Int, actual:Int, message:String)
		If expected = actual Then Return
		Fail("assertEquals() : expected:<" + expected + "> but was:<" + actual + "> " + message)
	End
	
	
	
	'summary: Asserts that two floats are equal.
	Method assertEquals:Void(expected:Float, actual:Float, message:String)
		If expected = actual Then Return		
		Fail("assertEquals() : expected:<" + expected + "> but was:<" + actual + "> " + message)
	End
	
	
	
	'summary: Asserts that an object is not null.
	Method assertNotNull:Void(obj:Object, message:String)
		If Not obj Then Fail("assertNotNull() : " + message)
	End
	
	
	
	'summary: Asserts that an object is null.
	Method assertNull:Void(obj:Object, message:String)
		If obj Then Fail("assertNull() : " + message)
	End
	
	
	
	'summary: Asserts that two objects refer to the same object.
	Method assertSame:Void(expected:Object, actual:Object, message:String)
		If expected <> actual Then Fail("assertSame() : " + message)		
	End
	
	
	
	'summary: Asserts that two objects refer different objects.
	Method assertNotSame:Void(expected:Object, actual:Object, message:String)
		If expected = actual Then Fail("assertNotSame() : " + message)
	End
	


	'summary: Throws a fail exception.
	Method Fail:Void(message:string)
		Throw AssertionFailedException.Create(message)
	End Method

End Class

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

		
	'summary: Asserts that two ints are NOT equal.
	Method assertNotEquals:Void(int1:Int, int2:Int, message:String)
		If int1 <> int2 Then Return
		Fail("assertNotEquals() : int1:<" + int1 + "> int2:<" + int2 + "> " + message)
	End
	
	
	'summary: Asserts that two floats are NOT equal.
	Method assertNotEquals:Void(float1:Float, float2:Float, message:String)
		If float1 <> float2 Then Return
		Fail("assertNotEquals() : float1:<" + float1 + "> float2:<" + float2 + "> " + message)
	End
	
	
	'summary: Asserts that two strings are NOT equal.
	Method assertNotEquals:Void(string1:String, string2:String, message:String)
		If string1 <> string2 Then Return
		Fail("assertNotEquals() : string1:<" + string1 + "> string2:<" + string2 + "> " + message)
	End
		

	'summary: Throws a fail exception.
	Method Fail:Void(message:string)
		Throw AssertionFailedException.Create(message)
	End Method

End Class
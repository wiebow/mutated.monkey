
'a couple of simple assert functions
'return true/false in release mode
'halts program when in debug mode

Strict

Private

Const DEFAULT_ERROR:String ="Assert"

Function AssertError:Void(msg:String)
	Print(msg)
	Error(msg)
End

Public

Function AssertTrue:Bool(b:Bool, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If b = False Then AssertError( message + " failed. AssertTrue Failed.")
	#End
	
	If b = False Then Return False
	Return True
End



Function AssertFalse:Bool(b:Bool, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If b = True Then AssertError( message + " failed. AssertFalse Failed." )	
	#End
	
	If b = True Then Return False
	Return True
End



Function AssertEqualsI:Bool( expected:Int, value:Int, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If (value <> expected ) Then
			AssertError( message + " failed. expected: " + expected + ", actual: " + value + ".")
		End
	#End
	
	If (value <> expected ) Then Return False
	Return True	
End



Function AssertEqualsF:Bool(expected:Float, value:Float, message:String = DEFAULT_ERROR)

	'some tolerance for float comparison
	Local approx:Float = 0.00001

	#If CONFIG = "debug"
		If Abs(value - expected) > approx 
			AssertError( message + " failed. expected: " + expected + ", actual: " + value + ".")
		End
	#End
	
	If Abs(value - expected) < approx Then Return False
	Return True		
End




Function AssertEqualsS:Bool(expected:String, value:String, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If value <> expected
			AssertError( message + " failed. expected: " + expected + ", actual: " + value + ".")
		End	
	#End
	
	If (value <> expected ) Then Return False
	Return True		
End



Function AssertSame:Bool( o1:Object, o2:Object, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If o1 <> o2
			AssertError( message + " failed. Objects are not the same.")	
		End
	#End
	
	If (o1 <> o2 ) Then Return False
	Return True
End



Function AssertNotSame:Bool( o1:Object, o2:Object, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If (o1 = o2 ) Then AssertError( message + " failed. Objects are the same.")
	#End
	
	If (o1 = o2 ) Then Return False
	Return True
End



Function AssertNull:Bool( o:Object, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If o <> Null Then AssertError( message + " failed. Object is not Null.")
	#End

	If o <> Null Then Return False
	Return True 	
End



Function AssertNotNull:Bool( o:Object, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If o = Null Then AssertError( message + " failed. Object is Null" )
	#End
	
	If o = Null Then Return False
	Return True 	
End


'a couple of simple assert functions
'return true/false in release mode
'halts program when in debug mode

Strict

Private


Function AssertError:Void(msg:String)
	Print(msg)
	Error(msg)
End

Public

Function AssertTrue:Bool(b:Bool)
	#If CONFIG = "debug"
		If b = False Then AssertError( "AssertTrue Failed.")
	#End
	
	If b = False Then Return False
	Return True
End



Function AssertFalse:Bool(b:Bool, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If b = True Then AssertError( "AssertFalse Failed." )	
	#End
	
	If b = True Then Return False
	Return True
End



Function AssertEquals:Bool( expected:Int, value:Int)
	#If CONFIG = "debug"
		If (value <> expected ) Then
			AssertError( "Int AssertEquals Failed: actual=" + value + ", expected=" + expected + ".")
		End
	#End
	
	If (value <> expected ) Then Return False
	Return True	
End



Function AssertEquals:Bool(expected:Float, value:Float)
	#If CONFIG = "debug"
		If (value <> expected ) Then
			AssertError( "Float AssertEquals Failed: actual=" + value + ", expected=" + expected + ".")
		End
	#End
	
	If (value <> expected ) Then Return False
	Return True		
End



Function AssertEquals:Bool(expected:Object, value:Object)
	#If CONFIG = "debug"
		If (value <> expected ) Then AssertError( "Object AssertEquals Failed. " )
	#End
	
	If (value <> expected ) Then Return False
	Return True		
End



Function AssertEquals:Bool(expected:String, value:String)
	#If CONFIG = "debug"
		If (value <> expected ) Then
			AssertError( "Float AssertEquals Failed: actual=" + value + ", expected=" + expected + ".")
		End	
	#End
	
	If (value <> expected ) Then Return False
	Return True		
End



Function AssertSame:Bool( o1:Object, o2:Object)
	#If CONFIG = "debug"
		If (o1 <> o2 ) Then AssertError( "Object AssertSame: Objects are not the same." )		
	#End
	
	If (o1 <> o2 ) Then Return False
	Return True
End



Function AssertNotSame:Bool( o1:Object, o2:Object)
	#If CONFIG = "debug"
		If (o1 = o2 ) Then AssertError( "Object AssertNotSame: Objects are the same." + message )		
	#End
	
	If (o1 = o2 ) Then Return False
	Return True
End



Function AssertNull:Bool( o:Object)
	#If CONFIG = "debug"
		If o <> Null Then AssertError( "Object AssertNull: Object is not Null.")
	#End

	If o <> Null Then Return False
	Return True 	
End



Function AssertNotNull:Bool( o:Object)
	#If CONFIG = "debug"
		If o = Null Then AssertError( "Object AssertNotNull: Object is Null" )
	#End
	
	If o = Null Then Return False
	Return True 	
End

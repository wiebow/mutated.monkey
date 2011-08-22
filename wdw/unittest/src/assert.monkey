
'a couple of simple assert functions
'return true/false in release mode
'halts program when in debug mode

Strict

Private

Const DEFAULT_ERROR:String = "Assert Failed!"

Function AssertError:Void(msg:String)
	Print(msg)
	Error(msg)
End

Public

Function AssertTrue:Bool(b:Bool, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If b = False Then AssertError( "AssertTrue: " + message )
	#End
	
	If b = False Then Return False
	Return True
End



Function AssertFalse:Bool(b:Bool, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If b = True Then AssertError( "AssertFalse: " + message )	
	#End
	
	If b = True Then Return False
	Return True
End



Function AssertEquals:Bool( value:Int, expected:Int, message:String = DEFAULT_ERROR )
	#If CONFIG = "debug"
		If (value <> expected ) Then AssertError( "Int AssertEquals: " + message )
	#End
	
	If (value <> expected ) Then Return False
	Return True	
End



Function AssertEquals:Bool( value:Float, expected:Float, message:String = DEFAULT_ERROR )
	#If CONFIG = "debug"
		If (value <> expected ) Then AssertError( "Float AssertEquals: " + message )
	#End
	
	If (value <> expected ) Then Return False
	Return True		
End



Function AssertEquals:Bool( value:Object, expected:Object, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If (value <> expected ) Then AssertError( "Object AssertEquals: " + message )
	#End
	
	If (value <> expected ) Then Return False
	Return True		
End



Function AssertEquals:Bool( value:String, expected:String, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If (value <> expected ) Then AssertError( "String AssertEquals: " + message )
	#End
	
	If (value <> expected ) Then Return False
	Return True		
End



Function AssertSame:Bool( o1:Object, o2:Object, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If (o1 <> o2 ) Then AssertError( "Object AssertSame: " + message )		
	#End
	
	If (o1 <> o2 ) Then Return False
	Return True
End



Function AssertNotSame:Bool( o1:Object, o2:Object, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If (o1 = o2 ) Then AssertError( "Object AssertNotSame: " + message )		
	#End
	
	If (o1 = o2 ) Then Return False
	Return True
End



Function AssertNull:Bool( o:Object, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If o <> Null Then AssertError( "Object AssertNull: " + message )
	#End

	If o <> Null Then Return False
	Return True 	
End



Function AssertNotNull:Bool( o:Object, message:String = DEFAULT_ERROR)
	#If CONFIG = "debug"
		If o = Null Then AssertError( "Object AssertNotNull: " + message )
	#End
	
	If o = Null Then Return False
	Return True 	
End

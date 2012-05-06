
Strict

Import mojo.graphics

Class Color

	Private
	
	Field _r:float
	Field _g:float
	Field _b:float
	Field _a:Float
	
	Public
	
	
	Method New(red:Float, green:Float, blue:Float, alpha:float)
		_r = red
		_g = green
		_b = blue
		_a = alpha
	End

		
	
	Method Set:Void(red:Float, green:Float, blue:Float, alpha:float)
		_r = red
		_g = green
		_b = blue
		_a = alpha
	End
		
		
	Method r:Float() Property
		Return _r
	End
	
	Method g:Float() property
		Return _g
	End
	
	Method b:Float() property
		Return _b
	End
	
	Method a:Float() property
		Return _a
	End
	
	Method Use:Void()
'		SetColor(_r, _g, _b)
'		SetAlpha(_a)
	End
	

End
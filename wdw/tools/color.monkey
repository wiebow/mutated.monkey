
Strict

Import mojo

'summary: Color and Alpha conveniece class.
Class Color

	Private
	
	'summary: Red component.
	Field _r:float
	
	'summary: Green component.
	Field _g:float
	
	'summary: Blue component.
	Field _b:float
	
	'summary: Alpha component.
	Field _a:Float
	
	Public
	
	
	'summary: Default constructor
	Method New(red:Float, green:Float, blue:Float, alpha:float)
		_r = red
		_g = green
		_b = blue
		_a = alpha
	End

		
	
	'summary: Sets all components.
	Method Set:Void(red:Float, green:Float, blue:Float, alpha:float)
		_r = red
		_g = green
		_b = blue
		_a = alpha
	End
		
		
	Method r:Float() Property
		Return _r
	End
	
	Method r:Void(red:Float) Property
		_r = red
	End
		
	Method g:Float() property
		Return _g
	End
	
	Method g:Void(green:Float) Property
		_g = green
	End
	
	Method b:Float() property
		Return _b
	End
	
	Method b:Void(blue:Float) Property
		_r = blue
	End
	
	Method a:Float() property
		Return _a
	End
    
    Method a:Void(alpha:Float) Property
        _a = alpha
    End
	
    
	
	'summary: Uses the color and alpha values.
	Method Use:Void()
		SetColor(_r, _g, _b)
		SetAlpha(_a)
	End
	

End
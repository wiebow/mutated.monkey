
'2d vector class.

Strict

'summary: A simple 2d vector class.
Class Vector2D
	
	Private
	
	Field _x:Float
	Field _y:Float
	
	Public
	
	'summary: creates a new vector with passed values.
	Method New(x:Float, y:Float)
		_x = x
		_y = y
	End	
	
	'summary: returns a clone of this vector.
	Method Clone:Vector2D()	
		Local v:= new Vector2D
		v.x = _x
		v.y = _y
		Return v
	End	
	
	'summary: copies the values from passed vector to this vector.
	Method Copy:Void(v:Vector2D)
		_x = v.x
		_y = v.y		
	End	
	
	'summary: sets this vector to passed values.
	Method Set:Void(x:Float, y:Float)
		_x = x
		_y = y
	End	
	
	'summary: returns the value of X
	Method x:Float() property
		Return _x
	End
		
	'summary: sets the value of X
	Method x:Void(x:Float) property
		_x = x
	End
		
	'summary: sets the value of Y
	Method y:Void(y:Float) property
		_y = y
	End
		
	'summary: returns the value of Y
	Method y:Float() property
		Return _y
	End
	
	'summary: adds passed values to this vector
	Method Add:Void(x:Float, y:Float)
		_x += x
		_y += y	
	End	
	
	'summary: adds passed vector to this vector
	Method Add:Void(v:Vector2D)
		_x += v.x
		_y += v.y
	End
	
	'summary: subtracts passed values from this vector
	Method Subtract:Void(x:Float, y:Float)
		_x -= x
		_y -= y
	End	
	
	'summary: subtracts passed vector from this vector
	Method Subtract:Void(v:Vector2D)
		_x -= v.x
		_y -= v.y
	End
	
	'summary: returns the length of this vector
	Method Length:Float()
		Return Sqrt(_x*_x + _y*_y)
	End
	
	'summary: divides this vector by passed value
	Method Divide:Void(f:Float)
		If f = 0.0 Then Error( "Divide by 0!" )
		_x /= f
		_y /= f
	End

	'summary: devides this vector by passed vector
	Method Divide:Void(v:Vector2D)
		If v.x = 0.0 or v.y = 0.0 Then Error( "Divide by 0!" )
		_x /= v.x
		_y /= v.y
	End
		
	'summary: multiplies this vector by passed value
	Method Multiply:Void(f:Float)
		_x *= f
		_y *= f	
	End
	
	'summary: multiplies this vector by passed vector
	Method Multiply:Void(v:Vector2D)
		_x *= v.x
		_y *= v.y
	End	
	
	'summary: make this vector length = 1.0
	Method Normalize:Void()
		Divide( Length() )
	End

	'summary: swaps values between this and passed vector	
	Method Swap:Void( v:Vector2D)
		Local temp:Float = _x
		_x = v.x
		v.x = temp
		
		temp = _y
		_y = v.y
		v.y = temp		
	End
		
	'summary: returns the dot product of this and passed vector
	Method Dot:Float( v:Vector2D )
		Return ( _x* v.x + _y*v.y )
	End
	
	'summary: returns the distance between this and passed vector
	Method Distance:Float( v:Vector2D)
		Local dx:Float = _x - v.x
		Local dy:Float = _y - v.y
		Return Sqrt(dx*dx + dy*dy )	
	End
	
	#rem
	summary: returns angle of vector rotation.
	Angle range is -180 to 180:
[code]
-135 -90 -45
    \ | /
+180 -+-  0
    / | \
+135 +90 +45
[/code]
	#end
	Method Rotation:Float()
		Return ATan2( y, x )
	End
	
	'summary: rotates this vector with specified amount, origin = 0,0
	Method Rotate:Void( theta:Float )
		Local cos:Float = Cos(theta)	
		Local sin:Float = Sin(theta)
		Local qx:Float =  _x * cos + _y * sin
		Local qy:Float = -_x * cos + _y * cos
		_x = qx
		_y = qy
	End

	'summary: rotates this vector with specified amount around passed vector
	Method Rotate:Void( theta:Float, v:Vector2D )
		Local cos:Float = Cos(theta)	
		Local sin:Float = Sin(theta)
		_x -= v.x
		_y -= v.y
		Local qx:Float =  _x * cos + _y * sin
		Local qy:Float = -_x * cos + _y * cos
		_x = qx + v.x
		_y = qy + v.y		
	End
		
	'summary: returns a string describing the vector values.	
	Method toString:String()
		Return "" + _x + "," + _y
	End

End
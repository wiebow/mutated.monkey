
Strict

Import transition
Import wdw.tools.color



'summary: A simple fade-in transition.
Class FadeInTransition Implements Transition
	
	Field _color:Color = New Color(0, 0, 0, 1.0)
	
	Field _transitionChange:Float
	
	
	
	Method New(r:Int, g:Int, b:Int, a:Float)
		_color.Set(r, g, b, a)
	End
	
	
	
	Method Init:Void()
		_color.a = 1.0

		'1 sec
		_transitionChange = 1.0 / UpdateRate()
	End

	
		
	Method Update:Void()
		_color.a -= _transitionChange
		If _color.a < 0.0 Then _color.a = 0.0
	End
	
	
	
	Method Render:Void()
		_color.Use()
		SetBlend(AlphaBlend)
		SetAlpha(_color.a)
			
		PushMatrix()
			Translate(0, 0)
			Rotate(0)
			Scale(1.0, 1.0)
			
			DrawRect(0, 0, DeviceWidth(), DeviceHeight())
		PopMatrix()
	End

	
	
	Method IsComplete:Bool()
		Return _color.a <= 0.0
	End
	
End
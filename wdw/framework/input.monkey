
Strict

Import mojo

'summary: Input Manager. Keys only.
Class Input

	Private
	
	'summary: Map holding a string-keycode mapping for each control.
	Field _keyControls:StringMap<Int>
	
	Public

	
	
	'summary: Default Constructor.	
	Method New()
		_keyControls = New StringMap<Int>
		AddControl("UP", KEY_UP)
		AddControl("DOWN", KEY_DOWN)
		AddControl("LEFT", KEY_LEFT)
		AddControl("RIGHT", KEY_RIGHT)
		AddControl("FIRE", KEY_Z)
	End
	
	
	
	'summary: Adds a control.
	Method AddControl:Void(label:String, code:Int)
		_keyControls.Add(label.ToUpper(), code)
	End
	
	
	
	'summary: Returns the mapping for specified control.
	Method GetControl:Int(label:String)
		Return _keyControls.Get(label.ToUpper())
	End
	
	
	
	'summary: Changes the value of a control.
	Method SetControl:Void(label:String, code:Int)
		_keyControls.Set(label.ToUpper(), code)
	End
	
	
		
	'summary: Returns true if the key mapped to the control is down.
	Method ControlDown:Bool(label:String)
		Return KeyDown(_keyControls.Get(label.ToUpper()))
	End

		
	
	'summary: Returns the amount of key hits since the last check.
	Method ControlHit:Int(label:String)
		Return KeyHit(_keyControls.Get(label.ToUpper()))
	End

End
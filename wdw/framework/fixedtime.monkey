
Strict

Import mojo


'summary: Fixed update timer class.
Class FixedTime

	Private
	
	Field _accumulator:Float
	Field _deltaTime:Float
	Field _time:Float

	Public
	
	
	#Rem
	summary:Default constructor.
	Default update rate is 30 fps.
	#end
	Method New()
		_deltaTime = 1000.0 / 30
	End
	
	
	Method DeltaTime:Float() Property
		Return _deltaTime
	End Method
	
	
	
	'summary: Convenience constructor.
	Method New(updateFrequency:Int)
		_deltaTime = 1000.0 / updateFrequency
	End


	
	'summary: Sets the timer update frequency.
	Method SetUpdateFrequency:Void(newFrequency:Int)
		_deltaTime = 1000.0 / newFrequency
	End
	
	
	
	'summary:Returns the render tweening value.
	Method GetTweening:Float()
		Return _accumulator / _deltaTime
	End
	
	
	
	'summary: Resets the timer.
	Method Reset:Void()
		_time = Millisecs()
		_accumulator = 0
	End
	
	
	
	'summary: Updates the timer.
	Method Update:Void()
		Local thisTime:Float = Millisecs()
		Local passedTime:Float = thisTime - _time
		
		_time = thisTime
		_accumulator += passedTime
	End
	
	
	
	'summary: Returns true if timestep needed.
	Method TimeStepNeeded:Bool()
		If _accumulator >= _deltaTime
			_accumulator -= _deltaTime
			Return True
		End
		Return False
	End
		
End
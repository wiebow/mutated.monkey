
Strict

Import wdw.framework



Function Main:Int()
	Local e:Engine = New Engine(New MyGame, 60)
	Return 0
End



Class MyGame Extends BasicGame

	Field xpos:Int = 100
	Field ypos:Int = 100
	
	
	
	Method Init:Void()
		Title = "Test"
	End
	
	
	
	Method Render:Void()
		Cls(255, 255, 255)
		SetColor 255, 0, 0
		DrawRect(xpos - 10, ypos - 10, 20, 20)
	End
	
	
	
	Method Update:Void()
		If KeyDown(KEY_UP) Then ypos -= 2
		If KeyDown(KEY_DOWN) Then ypos += 2		
		If KeyDown(KEY_LEFT) Then xpos -= 2
		If KeyDown(KEY_RIGHT) Then xpos += 2
	End

End

' simple resource manager

Strict

Import mojo


#rem
summary: A simple resource mananger.
This class is not instantiated. You can use its functions from anywhere.
#END
Class Resources

	Private
	
	Global _images:= New StringMap<Image>
	Global _sounds:= New StringMap<Sound>
	
	Public
	
	
	Function StoreImage:Void(imageName:String, img:Image)
		If img = Null Then Error("no pic!")
		_images.Set(imageName, img)
	End
	
	
	Function GetImage:Image(imageName:String)
		Return _images.ValueForKey(imageName)
	End


End
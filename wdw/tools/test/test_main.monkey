
'unit tests for tools module

Strict

#REFLECTION_FILTER="vector2d_test|color_test|reflection|wdw.unittest*"


Import vector2d_test
Import color_test


Function Main:Int()
	Local t:= New TestSuite
	t.Run()
	Return 0
End


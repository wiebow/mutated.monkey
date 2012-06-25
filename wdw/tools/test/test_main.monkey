
'unit tests for tools module

Strict

#REFLECTION_FILTER="*_test|reflection|wdw.unittest*"


'Import vector2d_test
'Import color_test
Import bag_test


Function Main:Int()
	Local t:= New TestSuite
	t.Run()
	Return 0
End



'unit tests for wdw.framework.

Strict

#REFLECTION_FILTER="*_test|reflection|wdw.unittest*"

Import fixedtime_test
Import engine_test
Import basicgame_test
Import statebasedgame_test



Function Main:Int()
	Local t:= New TestSuite
	t.Run()
	Return 0
End

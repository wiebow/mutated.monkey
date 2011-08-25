
'unit tests for Vector2D module

Strict

Import wdw.unittest
Import wdw.math.vector2d

Function Main:Int()

	'create a new test suite
	Local s:TestSuite = new TestSuite
	
	'create a new test and register it in the suite
	'this also registeres all defined unit tests
	Local t:VectorTest = New VectorTest
	t.TestName = "Vector Test"
	s.RegisterTest(t)

	'run the suite
	s.Run()	
End

'our custom test class
Class VectorTest extends Test

	'object to test
	Field testObject:Vector2D

	'a way to get to it
	Method TestObject:Vector2D() property
		Return testObject
	End
		
	'register unit tests in the test		
	Method RegisterTests:Void()
		RegisterUnitTest(New V_Constructor)
		RegisterUnitTest(New V_PropertyX)
		RegisterUnitTest(New V_AddFloat)
		RegisterUnitTest(New V_AddVector)
		RegisterUnitTest(New V_SubtractFloat)
		RegisterUnitTest(New V_SubtractVector)
		RegisterUnitTest(New V_Clone)
		RegisterUnitTest(New V_Set)
		RegisterUnitTest(New V_Length)
		RegisterUnitTest(New V_Divide)
		RegisterUnitTest(New V_DivideVector)
		RegisterUnitTest(New V_Normalise)
		RegisterUnitTest(New V_Copy)
		RegisterUnitTest(New V_Swap)
		RegisterUnitTest(New V_Multiply)
		RegisterUnitTest(New V_MultiplyVector)
		RegisterUnitTest(New V_Rotation)
		RegisterUnitTest(New V_Rotate)
		RegisterUnitTest(New V_RotateAbout)
	End
		
	'override
	Method SetUp:Void()
		testObject = New Vector2D
	End
	
	'override
	Method TearDown:Void()
		testObject = Null
	End
	
End



Class VectorUnit extends Unit	
	Method DoTest:Void( o:Vector2D ) Abstract

	Method Run:Void()
		DoTest( VectorTest(owner).TestObject )
	End
End

'tests
Class V_Constructor extends VectorUnit
	Method DoTest:Void( o:Vector2D )
		AssertNotNull(o)
	End	
End

Class V_PropertyX extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.x = 10.0
		AssertEqualsF(10.0, o.x, "Property X")
	End
End

Class V_PropertyY extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.y = 11.0
		AssertEqualsF(11.0, o.y, "Property Y")
	End
End

Class V_AddFloat extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Add( 5.0, 6.0 )
		AssertEqualsF(5.0, o.x, "Add Float X")
		AssertEqualsF(6.0, o.y, "Add Float Y")
	End
End

Class V_AddVector extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.x = 10
		o.y = 10
		o.Add( New Vector2D(2, 4) )
		AssertEqualsF(12.0, o.x, "Add Vector X")
		AssertEqualsF(14.0, o.y, "Add Vector Y")
	End
End

Class V_SubtractFloat extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.x = 10
		o.y = 10
		o.Substract( 5, 4 )
		AssertEqualsF(5.0, o.x, "Substract Float X")
		AssertEqualsF(6.0, o.y, "Substract Float Y")
	End
End

Class V_SubtractVector extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.x = 10
		o.y = 10
		o.Substract( New Vector2D(2,4) )
		AssertEqualsF(8.0, o.x, "Substract Vector X")
		AssertEqualsF(6.0, o.y, "Substract Vector Y")
	End
End

Class V_Clone extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.x = 10
		o.y = 12	
		Local v:Vector2D = o.Clone()			
		AssertEqualsF(10.0, v.x, "Clone X")
		AssertEqualsF(12.0, v.y, "Clone Y")
	End
End

Class V_Set extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Set(10,12)
		AssertEqualsF(10.0, o.x)
		AssertEqualsF(12.0, o.y)
	End
End

Class V_Divide extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Set(10,0)
		o.Divide(2)
		AssertEqualsF(5.0, o.Length())
	End
End

Class V_DivideVector extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Set(10,20)
		Local o2:= New Vector2D(2,4)
		o.Divide(o2)
	
		AssertEqualsF(5.0, o.x)
		AssertEqualsF(5.0, o.y)
	End
End

Class V_Length extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Set(10,0)
		AssertEqualsF(10.0, o.Length())
	End
End

Class V_Normalise extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Set(10,0)
		o.Normalise()
		AssertEqualsF(1.0, o.Length())
	End
End

Class V_Copy extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Set(10,20)
		Local o2:= New Vector2D
		o2.Copy(o)

		AssertEqualsF(10.0, o2.x)
		AssertEqualsF(20.0, o2.y)
	End
End

Class V_Swap extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Set(10,20)
		Local o2:= New Vector2D(15,25)
		o.Swap(o2)

		AssertEqualsF(15.0, o.x)
		AssertEqualsF(25.0, o.y)
		AssertEqualsF(10.0, o2.x)
		AssertEqualsF(20.0, o2.y)		
	End
End

Class V_Multiply extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Set(1,2)
		o.Multiply(10)
		AssertEqualsF(10.0, o.x)
		AssertEqualsF(20.0, o.y)
	End
End

Class V_MultiplyVector extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Set(2,4)
		Local o2:= New Vector2D
		o2.Set(2,4)
		o.Multiply(o2)		
		
		AssertEqualsF(4.0, o.x, "Multiply Vector X")
		AssertEqualsF(16.0, o.y, "Multiply Vector Y")
	End
End

Class V_Rotation extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Set(0,-1)
		AssertEqualsF(-90.0, o.Rotation(), "Rotation 1")
		
		o.Set(-1,1)
		AssertEqualsF(135.0, o.Rotation(), "Rotation 2")
	End
End

Class V_Rotate extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Set(0,-1)										'angle = -90
		o.Rotate(-45)									'rotate -45 degrees
		AssertEqualsF(-45.0, o.Rotation(), "Rotate")	'should be -45 now.
	End
End

Class V_RotateAbout extends VectorUnit
	Method DoTest:Void(o:Vector2D)
		o.Set(0,2)
		Local o2 := new Vector2D(0,1)
		o.Rotate(-90, o2)
		AssertEqualsF(135.0, o.Rotation(), "RotateAbout")
	End
End

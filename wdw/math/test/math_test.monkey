
'unit tests for vector2d

Strict

#REFLECTION_FILTER="math_test|reflection|wdw.unittest*"

Import wdw.unittest
Import wdw.math


Function Main:Int()
	Local t:= new TestSuite
	t.Run()
	Return 0
End


Class Vector2DTest extends Test
	
	Field v:Vector2D
	
	Method dothisBefore:Void() 
		v = New Vector2D
	End
	
	Method dothisAfter:Void()
		v = Null
	End	
	
	Method PropertyXTest:Void()
		v.x = 10.0
		assertEquals(10.0, v.x, "Property X")
	End
	
	Method PropertyYTest:Void()
		v.y = 6.0
		assertEquals(6.0, v.y, "Property Y")
	End
	
	Method AddTest:Void()
		v.Add( 5.0, 6.0)
		assertEquals(5.0, v.x, "Add Float X")
		assertEquals(6.0, v.y, "Add Float Y")
	End
	
	Method AddVectorTest:Void()
		v.x = 10
		v.y = 5
		v.Add( New Vector2D(2,4))
		assertEquals(12.0, v.x, "Add Vector X")
		assertEquals(9.0, v.y, "Add Vector Y")
	End
	
	Method SubtractTest:Void()
		v.x = 10
		v.y = 5
		v.Subtract( 2, 4 )
		assertEquals(8.0, v.x, "Subtract X")
		assertEquals(1.0, v.y, "Subtract Y")
	End
	
	Method SubtractVectorTest:Void()
		v.x = 10
		v.y = 5
		v.Subtract( New Vector2D(2,4))
		assertEquals(8.0, v.x, "Subtract X")
		assertEquals(1.0, v.y, "Subtract Y")
	End
	
	Method CloneTest:Void()
		v.x = 10
		v.y = 5
		Local v2:= v.Clone()
		assertEquals(10.0, v2.x, "Clone X")
		assertEquals(5.0, v2.y, "Clone Y")
	End
	
	Method SetTest:Void()
		v.Set(10,12)
		assertEquals(10.0, v.x, "Set X")
		assertEquals(12.0, v.y, "Set Y")
	End
	
	Method DivideTest:Void()
		v.Set(10, 0)
		v.Divide(2)
		assertEquals(5.0, v.x, "Divide X")
		assertEquals(0.0, v.y, "Divide Y")
	End

	Method DivideVectorTest:Void()
		v.Set(10,20)
		v.Divide( New Vector2D(2,4))
		
		assertEquals(5.0, v.x, "Divide Vector X")
		assertEquals(5.0, v.y, "Divide Vector Y")
	End

	Method LengthTest:Void()
		v.Set(10,0)
		assertEquals(10.0, v.Length(), "Length")
	End

	Method NormalizeTest:Void()
		v.Set(10,0)
		v.Normalize()
		assertEquals(1.0, v.Length(), "Normalize")
	End
	
	Method CopyTest:Void()
		v.Set(10,20)
		Local v2:= New Vector2D
		v2.Copy(v)
		
		assertEquals(10.0, v2.x, "")
		assertEquals(20.0, v2.y, "")
	End
	
	Method SwapTest:Void()
		v.Set(10,20)
		Local v2:= new Vector2D(15,25)
		v.Swap(v2)
		
		assertEquals(15.0, v.x, "")
		assertEquals(25.0, v.y, "")
		assertEquals(10.0, v2.x, "")
		assertEquals(20.0, v2.y, "")
	End
	
	Method MultiplyTest:Void()
		v.Set(1,2)
		v.Multiply(10)
		
		assertEquals(10.0, v.x, "")
		assertEquals(20.0, v.y, "")
	End
	
	Method MultiplyVectorTest:Void()
		v.Set(1,2)
		Local v2:= New Vector2D(2,4)
		v.Multiply(v2)
		
		assertEquals( 2.0, v.x, "")
		assertEquals( 8.0, v.y, "")
	End
	
	Method RotationTest:Void()
		v.Set(0,-1)
		assertEquals(-90.0, v.Rotation(), "Rotation 1")
		
		v.Set(-1,1)
		assertEquals(135.0, v.Rotation(), "Rotation 2")
	End
	
	Method RotateVectorTest:Void()
		v.Set(0,-1)
		v.Rotate(-45)
		assertEquals(-45.0, v.Rotation(), "")
	End
	
	Method RotateAboutTest:Void()
		v.Set(0.0,2.0)
		v.Rotate( -90.0, New Vector2D(0.0,1.0))
		assertEquals(135.0, v.Rotation(), "")
	End
	
End

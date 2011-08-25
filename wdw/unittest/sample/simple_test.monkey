
Strict

Import wdw.unittest

Function Main:Int()

	'create a new test suite
	Local s:TestSuite = new TestSuite
	
	'create a new test and register it in the suite
	Local t:DummyTest = New DummyTest
	t.TestName = "Dummy Test"
	s.RegisterTest(t)
	
	'run the tests in the suite
	s.Run()	
End


'the class we want to test. normally you import this
Class Dummy
	Method Add:Int( i1:Int, i2:Int )
		Return (i1 + i2)
	End
End


'our custom test class
Class DummyTest extends Test


	'object to test
	Field testObject:Dummy
	
	'a way to get to it
	Method TestObject:Dummy() property
		Return testObject
	End
	
	
	'register unit tests in the test	
	'is called when the test is added to the suite
	Method RegisterTests:Void()
		RegisterUnitTest(New T_Constructor)
		RegisterUnitTest(New T_Add)
		RegisterUnitTest(New T_AddFail)		
	End
			
	
	'override
	Method SetUp:Void()
		testObject = New Dummy
	End
	
	'override
	Method TearDown:Void()
		testObject = Null
	End
End



'crappy. each unit test is, for now, a class as well.
'luckily, i am not aiming for speed atm.

'this is the custom base test class we are going to use.
'it performs the necessary casting
'extend it and use the DoTest() method in each test.
Class DummyUnit extends Unit	
	Method DoTest:Void( d:Dummy ) Abstract

	Method Run:Void()
		DoTest( DummyTest(owner).TestObject )
	End
End

'a test
Class T_Constructor extends DummyUnit
	Method DoTest:Void( d:Dummy )	
		'pass a string as well to identify the test in case it fails.
		AssertNotNull( d, "Constructor" )
	End	
End

'another test
Class T_Add extends DummyUnit	
	Method DoTest:Void( d:Dummy )
		AssertEqualsI( d.Add( 5, 6 ), 11, "Add")
	End
End

'this test fails
Class T_AddFail extends DummyUnit	
	Method DoTest:Void( d:Dummy )
		AssertEqualsI( d.Add( 5, 6 ), 12, "Add 2")
	End
End

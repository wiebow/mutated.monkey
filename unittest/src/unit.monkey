#rem
	header: This module contains the base class for unit tests.
#end


Strict

Import test


#rem
	summary: Unit test base class
	This class is [i]abstract[/i] and must be extended for use in your tests.
	As casting is required to retrieve the test object from the test calling the unit test,
	the [b]Unit[/b] class must be extended twice. First so the Run() method can retrieve and cast
	the text object, and then for each unit test.

	Example:	
	[code]
Class DummyUnit extends Unit	
	Method DoTest:Void( d:Dummy ) Abstract

	Method Run:Void()
		DoTest( DummyTest(owner).TestObject )
	End
End

Class T_Constructor extends DummyUnit
	Method DoTest:Void( d:Dummy )
		AssertNotNull( d, "Object must not be Null." )
	End	
End	
	[/code]
	
	Once Monkey supports Reflection, this somewhat cumbersome method will be simplified.		
	
#end
Class Unit Abstract

	'summary: Field containing the owning test class. Set using RegisterOwner()
	Field owner:Test
	
	
	#rem
		summary: Entry method for the test framework.
		This method is called when a unit test is starting. One use is to call your test scenario
		specific object retriever, and then to call a test method.
		
		Example:
		[code]
Class DummyUnit extends Unit	
	Method DoTest:Void( d:Dummy ) Abstract

	Method Run:Void()
		DoTest( DummyTest(owner).TestObject )
	End
End
		[/code]
	#end
	Method Run:Void() abstract
	
	
	
	#rem
		summary: Called by Test when registering this unit test.
	    Do not use this method. It will set the owner field to the test that will run this unit test.
	#end
	Method RegisterOwner:Void( t:Test )
		owner = t
	End
		
End

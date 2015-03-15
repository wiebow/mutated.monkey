# Introduction #

Unit testing allows you to test if a particular piece of code is working correctly.

# Details #

This module uses reflection to automatically add your tests to the suite.  As pioneered by Brucey with [maxunit](http://code.google.com/p/maxmods/wiki/MaxUnitModule).
As the module uses Try/Catch and Exception handling, and the new reflection filter definition, Monkey v66 or up is required.

# How to use #

Import the unittest module and the files containing the test classes. In this example the file `simple_test` also contains the test class.

**TIP:** If you use `_test` as the last part of each of your unit test file names, you can use `*_test` as your reflection filter to automatically add each test. Ensure that these test files are in the same folder as the main file.

```
Strict

#REFLECTION_FILTER+="*_test"

Import wdw.unittest
Import simple_test

Function Main:Int()
	Local t:TestSuite = New TestSuite
	t.Run()
	Return 0
End
```

The next thing to do is to create your test class. The class name must end with `Test`. In this example the following code is located in the file `simple_test`, as imported in the main test code above.

You extend the Test class to create your own test class. Each method in the test class ending with `Test` will be run by the Test Suite. A method ending with `Before` will be run before each unit test, and the method ending with `After` will be ran, guess what, after each unit test.

```
Strict
Import myclass

Class MyClassTest Extends Test	
	Field m:MyClass
	
	Method dothisBefore:Void()
		'we do this before each unit test
		m = New MyClass
	End
	
	Method dothisAfter:Void()
		'we do this after each unit test
		m = Null
	End	
	
	Method constructorTest:Void()
		Self.assertNotNull(m, "")
	End	

        'this test will fail, of course.		
	Method constructorFailingTest:Void()
		Self.assertNull(m, "fail!")
	End	
End
```

This is the class you want to test. It is located in the file `myclass`, as imported in the file `simple_test`.
```
Strict
Class MyClass	
	Private	
	Field simplefield:Int
	Public	
	
	Method Simplefield:Int(i:Int) Property
		simplefield = i
		Return 0
	End
	
	Method Simplefield:Int() Property
		Return simplefield
	End
End
```
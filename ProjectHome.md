

NOTE: I am no longer using Monkey. At least, not for the forseeable future.
These repositories will no longer be updated.



A collection of free modules for the [Monkey](http://monkeycoder.co.nz/) language.

This project uses Mercurial. The repository also includes the Jungle IDE project files. I wanted to keep the repository IDE neutral but I develop on multiple machines.

All module folders must be put in the folder `[monkeypath]/modules/wdw/`

All my modules and code use unit testing. Unit testing is a way to validate that a particular section of code works properly. The tests are located in the test subfolder of each module. You require `wdw.unittest` if you want to run the tests yourself.


  * [framework](framework.md): a state-based 2d game framework, enabling easy game development.  Work in progress, use at your own risk!
  * [quadtree](quadtree.md): quickly find objects using space partitioning.
  * [unittest](unittest.md): a unit-test module using reflection, inspired by JUnit and Maxunit
  * [tools](tools.md): various classes to make life easier
    * vector2d: your typical vector class
    * color: RGBA convenience class
    * bag: fast, array based, unsorted collection class.
    * rectangle: define rectangular areas, comes with overlap and inside checks.

...more to come



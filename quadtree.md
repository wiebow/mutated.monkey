# quadtree #

This module allows the creation of quadtrees. Items in the tree can be quickly found by using simple rectangle overlap checks, which is ideal for collision checks or camera viewports in large scrolling areas.

A QuadTree covers a rectangular area. QuadTreeNodes partition this area and these nodes can be partitioned again as well. A QuadTreeNode contains the QuadTreeItems which fit into the node area.

![https://dl.dropboxusercontent.com/u/12644619/pics/dev/quadTree01.jpg](https://dl.dropboxusercontent.com/u/12644619/pics/dev/quadTree01.jpg)

A node will subdivide itself into four new nodes when the amount of items in the node exceeds a certain amount (the default in the module is 50) and its items will be distributed over these new child nodes.


## Types ##

The module consists of the following types:

  * **QuadTree** : Overall manager.
  * **QuadTreeNode** : a tree node which can be partitioned into 4 sections.
  * **QuadTreeItem** : an item containing area (bounding box) information.
  * **Rectangle** : all areas are defined by a Rectangle, includes contain and overlap methods.


## How to use ##

Put the module source in the module folder. The path should look like `monkey\modules\wdw\quadtree\`

It is best to create a tree with the correct area size before adding all objects. Resizing the world is done automatically but is a costly operation when the tree already holds a lot of nodes and items.
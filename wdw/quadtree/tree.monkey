
Strict

Import node

Const DEFAULT_MAX_ITEMS:Int = 50

'summary: Partioned space quad tree.
Class QuadTree

	Private
	
	'root node
	Field head:QuadTreeNode
	
	'max items in a node before partioning.
	Field maxItems:Int
	
	'total world size.
	Field area:Rectangle
	
	'list used for items and resizing of tree.
	Field itemList:List<QuadTreeItem>
	
	Public
	
	
	'summary: Constructor.
	Method New(x:Int, y:Int, w:Int, h:Int)
		Self.area = New Rectangle(x, y, w, h)
		Self.maxItems = DEFAULT_MAX_ITEMS
		Self.head = New QuadTreeNode(x, y, w, h, Self, Self.maxItems, Null)
		Self.itemList = New List<QuadTreeItem>
	End Method
	
	
	'summary: Sets max items for a node in this tree.
	Method MaxItems:Void(i:Int) Property
		maxItems = i
	End Method
		
	
	'summary: Returns the max items for a node in this tree.
	Method MaxItems:Int() Property
		Return maxItems
	End Method
	
	
	'summary: Inserts an item in the tree.
	Method InsertItem:Void(i:QuadTreeItem)
		If Not area.ContainsRectangle(i.BoundingBox)
			Resize(i.BoundingBox)
		End If
		
		'add item
		head.InsertItem(i)
	End Method
	
	
	'resizes the world until passed rectangle fits inside.
	'and then re-enters all the items.
	Method Resize:Void(r:Rectangle)
		While Not area.ContainsRectangle(r)
			area.SetPosition(area.x * 2, area.y * 2)
			area.SetDimension(area.width * 2, area.height * 2)
		End While
		
		'done. get all items in the tree.
		itemList.Clear()
		head.GetAllItems(itemList)
		
		'cut down tree.
		head.Free()
		head = Null
		
		'create new root.
		head = New QuadTreeNode(area.x, area.y, area.width, area.height, Self, maxItems, Null)
		
		're-insert items.
		For Local i:QuadTreeItem = EachIn itemList
			head.InsertItem(i)
		End For
	
	End Method
	
	
	'summary: Returns a list of all items in the tree that are overlapped by passed rectangle.	
	Method GetItems:List(r:Rectangle)
		itemList.Clear()
		head.GetItems(itemList, r)
		Return itemList
	End Method
	
	
	'summary: Returns a list of all the items in the tree.
	Method GetAllItems:List()
		itemList.Clear()
		head.GetAllItems(itemList)
		Return itemList
	End Method
	
	
	Method Area:Rectangle() Property
		Return area
	End Method
	
	
	Method Head:QuadTreeNode() Property
		Return head
	End Method
	
End Class
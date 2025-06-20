Class extends Entity


exposed Function $getorderDetail() : Text
	return (This:C1470.table=Null:C1517) ? "Ordered by "+String:C10(This:C1470.ordererFullName)+" at "+String:C10(This:C1470.ordererAddress) : "Table "+String:C10(This:C1470.table.integerTable)
	
exposed Function $gettotalPrice() : Integer  // $get the dishes ->$get the price
	return This:C1470.orderDishes.sum("totalPrice")
	
exposed Function $getitemNum() : Integer  //item integers displayed in the orders matrix
	return (This:C1470.orderDishes.length#0) ? This:C1470.orderDishes.sum("quantity") : 0
	
exposed Function saveFullOrder() : cs:C1710.OrderEntity
	var $saved : Object
	If (ds:C1482.requiredField(This:C1470.waiter.user.fullName; "newOrderWaiter"))
		Web Form:C1735.setError("Select a waiter first!")
	Else 
		If (ds:C1482.requiredField(This:C1470.type; "orderType"))
			Web Form:C1735.setError("Select your order type!")
		Else   //setting up the new order
			This:C1470.orderDate:=Current date:C33()
			This:C1470.orderingHour:=Current time:C178()
			This:C1470.status:="Placed"
			$saved:=This:C1470.save()
			Web Form:C1735.newOrderDish.show()
		End if 
	End if 
	return This:C1470
	
exposed Function decrementQuantity()  //used in the ordering process to decrement the $quantity of the used products in all the ordered dishes
	var $product : cs:C1710.ProductEntity
	If (This:C1470.orderDishes.length#0)
		For each ($product; This:C1470.orderDishes.dish.dishProducts.product)
			$product.availableQuantity-=1
			$product.save()
			If ($product.availableQuantity<=50)
				Web Form:C1735.setWarning("you are "+String:C10($product.availableQuantity)+" units away from reaching your stock limit of the "+String:C10($product.name)+" !")
			End if 
		End for each 
	End if 
	
exposed Function checkStatus()
	Case of 
		: ((This:C1470.status="Placed") && Not:C34(Session:C1714.hasPrivilege("manageSections")))  //placed for waiter  (see nothing but deliver)
			ds:C1482.setCss("displayForChef"; "visibility")
			ds:C1482.setCss("displayForWaiter"; "visibility")
			Web Form:C1735.removeDishButton.show()
			Web Form:C1735.addDishToOrder.show()
			Web Form:C1735.dishQuantity.show()
			
		: ((This:C1470.status="Placed") && Session:C1714.hasPrivilege("manageSections"))  //placed for chef or superAdmin 
			ds:C1482.removeCss("displayForChef"; "visibility")
			ds:C1482.setCss("displayForWaiter"; "visibility")
			ds:C1482.setCss("displayForChef1"; "visibility")
			Web Form:C1735.removeDishButton.show()
			Web Form:C1735.addDishToOrder.show()
			Web Form:C1735.dishQuantity.show()
			
		: ((This:C1470.status="In Progress") && Not:C34(Session:C1714.hasPrivilege("manageSections")))  //in progress for waiter (see nothing but deliver)
			ds:C1482.setCss("displayForChef1"; "visibility")
			ds:C1482.setCss("displayForChef"; "visibility")
			ds:C1482.setCss("displayForWaiter"; "visibility")
			Web Form:C1735.removeDishButton.hide()
			Web Form:C1735.addDishToOrder.hide()
			Web Form:C1735.dishQuantity.hide()
			
		: (This:C1470.status="In Progress")  //in progress for chef or admin
			ds:C1482.setCss("displayForChef"; "visibility")
			ds:C1482.removeCss("displayForChef1"; "visibility")
			ds:C1482.setCss("displayForWaiter"; "visibility")
			Web Form:C1735.removeDishButton.hide()
			Web Form:C1735.addDishToOrder.hide()
			Web Form:C1735.dishQuantity.hide()
			
		: (This:C1470.status="Ready")  //ready for chef or superAdmin 
			ds:C1482.removeCss("displayForWaiter"; "visibility")
			ds:C1482.setCss("displayForChef1"; "visibility")
			ds:C1482.setCss("displayForChef"; "visibility")
			Web Form:C1735.removeDishButton.hide()
			Web Form:C1735.addDishToOrder.hide()
			Web Form:C1735.dishQuantity.hide()
			
		: (This:C1470.status="Delivered")  //delivered for chef or superAdmin 
			ds:C1482.setCss("displayForWaiter"; "visibility")
			ds:C1482.setCss("displayForChef"; "visibility")
			ds:C1482.setCss("displayForChef1"; "visibility")
			Web Form:C1735.removeDishButton.hide()
			Web Form:C1735.addDishToOrder.hide()
			Web Form:C1735.dishQuantity.hide()
			
	End case 
	
exposed Function groupedOrderDishes() : Collection
	var $distinctDishes : Collection
	This:C1470.reload()
	$distinctDishes:=This:C1470.orderDishes.dish.distinct("name").sort()
	var $distinctDish : Text
	var $groupedOrderDishes : Collection:=New collection:C1472()
	var $orderDish : cs:C1710.OrderDishEntity
	var $orderOD : cs:C1710.OrderDishSelection
	$orderOD:=This:C1470.orderDishes.orderBy("dish.name")
	var $quantity : Integer
	
	For each ($distinctDish; $distinctDishes)
		$quantity:=0
		For each ($orderDish; $orderOD)
			If ($orderDish.dish.name=$distinctDish)
				$quantity+=$orderDish.quantity
			End if 
		End for each 
		$groupedOrderDishes.push(New object:C1471("dish"; $distinctDish; "quantity"; $quantity; "price"; ds:C1482.Dish.query("name = :1"; $distinctDish).first().price))
	End for each 
	return $groupedOrderDishes
	
exposed Function minuss($dishName : Text) : Collection
	var $orderDish : cs:C1710.OrderDishEntity
	var $output : Collection
	If (This:C1470.orderDishes.query("dish.name = :1"; $dishName).length#0)
		$orderDish:=This:C1470.orderDishes.query("dish.name = :1"; $dishName).first()
		$orderDish.decrementQuantity()
	Else 
		Web Form:C1735.setError("Error")
	End if 
	$output:=This:C1470.groupedOrderDishes()
	return $output
	
exposed Function pluss($dishName : Text) : Collection
	var $orderDish : cs:C1710.OrderDishEntity
	If (This:C1470.orderDishes.query("dish.name = :1"; $dishName).length#0)
		$orderDish:=This:C1470.orderDishes.query("dish.name = :1"; $dishName).first()
		$orderDish.incrementQuantity()
	Else 
		Web Form:C1735.setError("Error")
	End if 
	return This:C1470.groupedOrderDishes()
	
exposed Function removeOrderDishes($orderDish : Object) : Collection
	var $orderDishes : cs:C1710.OrderDishSelection
	var $status : cs:C1710.OrderDishSelection
	$orderDishes:=This:C1470.orderDishes.query("dish.name = :1"; $orderDish.dish)
	If ($orderDishes.length#0)
		$status:=$orderDishes.drop()
		If ($status.length=0)
			Web Form:C1735.setMessage("Removed!")
		Else 
			Web Form:C1735.setError("Error")
		End if 
	End if 
	return This:C1470.groupedOrderDishes()
	
	
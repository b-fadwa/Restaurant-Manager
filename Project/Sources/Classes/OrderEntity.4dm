Class extends Entity


exposed Function get orderDetail() : Text
	return (This:C1470.table=Null:C1517) ? "Ordered by "+String:C10(This:C1470.ordererFullName)+" at "+String:C10(This:C1470.ordererAddress) : "Table "+String:C10(This:C1470.table.integerTable)
	
exposed Function get totalPrice() : Integer
	return This:C1470.orderDishes.sum("totalPrice")
	
exposed Function get itemNum() : Integer
	return (This:C1470.orderDishes.length#0) ? This:C1470.orderDishes.sum("quantity") : 0
	
exposed Function saveFullOrder() : cs:C1710.OrderEntity
	var $saved : Object
	If (ds:C1482.requiredField(This:C1470.waiter.user.fullName; "newOrderWaiter"))
		Web Form:C1735.setError("Select a waiter first!")
	Else 
		If (ds:C1482.requiredField(This:C1470.type; "orderType"))
			Web Form:C1735.setError("Select your order type!")
		Else 
			This:C1470.orderDate:=Current date:C33()
			This:C1470.orderingHour:=Current time:C178()
			This:C1470.status:="Placed"
			$saved:=This:C1470.save()
			Web Form:C1735.newOrderDish.show()
		End if 
	End if 
	return This:C1470
	
	
	// Decrements product stock quantities for ordered dishes and warns when stock reaches a low threshold.
exposed Function decrementQuantity()
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
	
	// Groups order dishes by dish name and returns their total quantities and prices.
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
	
	
	// Decreases or increases the quantity of a dish in the order by name and returns the updated grouped order summary.
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
	
	// Removes all order-dish entries matching the given dish and returns the updated grouped order summary.
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
	
	
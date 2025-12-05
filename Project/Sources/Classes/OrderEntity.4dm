Class extends Entity


exposed Function get orderDetail() : Text
	return (This.table=Null) ? "Ordered by "+String(This.ordererFullName)+" at "+String(This.ordererAddress) : "Table "+String(This.table.integerTable)
	
exposed Function get totalPrice() : Integer  
	return This.orderDishes.sum("totalPrice")
	
exposed Function get itemNum() : Integer 
	return (This.orderDishes.length#0) ? This.orderDishes.sum("quantity") : 0
	
exposed Function saveFullOrder() : cs.OrderEntity
	var $saved : Object
	If (ds.requiredField(This.waiter.user.fullName; "newOrderWaiter"))
		Web Form.setError("Select a waiter first!")
	Else 
		If (ds.requiredField(This.type; "orderType"))
			Web Form.setError("Select your order type!")
		Else   
			This.orderDate:=Current date()
			This.orderingHour:=Current time()
			This.status:="Placed"
			$saved:=This.save()
			Web Form.newOrderDish.show()
		End if 
	End if 
	return This
	
exposed Function decrementQuantity()  
	var $product : cs.ProductEntity
	If (This.orderDishes.length#0)
		For each ($product; This.orderDishes.dish.dishProducts.product)
			$product.availableQuantity-=1
			$product.save()
			If ($product.availableQuantity<=50)
				Web Form.setWarning("you are "+String($product.availableQuantity)+" units away from reaching your stock limit of the "+String($product.name)+" !")
			End if 
		End for each 
	End if 
	
exposed Function checkStatus()
	Case of 
		: ((This.status="Placed") && Not(Session.hasPrivilege("manageSections")))  
			ds.setCss("displayForChef"; "visibility")
			ds.setCss("displayForWaiter"; "visibility")
			Web Form.removeDishButton.show()
			Web Form.addDishToOrder.show()
			Web Form.dishQuantity.show()
			
		: ((This.status="Placed") && Session.hasPrivilege("manageSections"))   
			ds.removeCss("displayForChef"; "visibility")
			ds.setCss("displayForWaiter"; "visibility")
			ds.setCss("displayForChef1"; "visibility")
			Web Form.removeDishButton.show()
			Web Form.addDishToOrder.show()
			Web Form.dishQuantity.show()
			
		: ((This.status="In Progress") && Not(Session.hasPrivilege("manageSections")))  
			ds.setCss("displayForChef1"; "visibility")
			ds.setCss("displayForChef"; "visibility")
			ds.setCss("displayForWaiter"; "visibility")
			Web Form.removeDishButton.hide()
			Web Form.addDishToOrder.hide()
			Web Form.dishQuantity.hide()
			
		: (This.status="In Progress")  
			ds.setCss("displayForChef"; "visibility")
			ds.removeCss("displayForChef1"; "visibility")
			ds.setCss("displayForWaiter"; "visibility")
			Web Form.removeDishButton.hide()
			Web Form.addDishToOrder.hide()
			Web Form.dishQuantity.hide()
			
		: (This.status="Ready")  
			ds.removeCss("displayForWaiter"; "visibility")
			ds.setCss("displayForChef1"; "visibility")
			ds.setCss("displayForChef"; "visibility")
			Web Form.removeDishButton.hide()
			Web Form.addDishToOrder.hide()
			Web Form.dishQuantity.hide()
			
		: (This.status="Delivered")   
			ds.setCss("displayForWaiter"; "visibility")
			ds.setCss("displayForChef"; "visibility")
			ds.setCss("displayForChef1"; "visibility")
			Web Form.removeDishButton.hide()
			Web Form.addDishToOrder.hide()
			Web Form.dishQuantity.hide()
			
	End case 
	
exposed Function groupedOrderDishes() : Collection
	var $distinctDishes : Collection
	This.reload()
	$distinctDishes:=This.orderDishes.dish.distinct("name").sort()
	var $distinctDish : Text
	var $groupedOrderDishes : Collection:=New collection()
	var $orderDish : cs.OrderDishEntity
	var $orderOD : cs.OrderDishSelection
	$orderOD:=This.orderDishes.orderBy("dish.name")
	var $quantity : Integer
	
	For each ($distinctDish; $distinctDishes)
		$quantity:=0
		For each ($orderDish; $orderOD)
			If ($orderDish.dish.name=$distinctDish)
				$quantity+=$orderDish.quantity
			End if 
		End for each 
		$groupedOrderDishes.push(New object("dish"; $distinctDish; "quantity"; $quantity; "price"; ds.Dish.query("name = :1"; $distinctDish).first().price))
	End for each 
	return $groupedOrderDishes
	
exposed Function minuss($dishName : Text) : Collection
	var $orderDish : cs.OrderDishEntity
	var $output : Collection
	If (This.orderDishes.query("dish.name = :1"; $dishName).length#0)
		$orderDish:=This.orderDishes.query("dish.name = :1"; $dishName).first()
		$orderDish.decrementQuantity()
	Else 
		Web Form.setError("Error")
	End if 
	$output:=This.groupedOrderDishes()
	return $output
	
exposed Function pluss($dishName : Text) : Collection
	var $orderDish : cs.OrderDishEntity
	If (This.orderDishes.query("dish.name = :1"; $dishName).length#0)
		$orderDish:=This.orderDishes.query("dish.name = :1"; $dishName).first()
		$orderDish.incrementQuantity()
	Else 
		Web Form.setError("Error")
	End if 
	return This.groupedOrderDishes()
	
exposed Function removeOrderDishes($orderDish : Object) : Collection
	var $orderDishes : cs.OrderDishSelection
	var $status : cs.OrderDishSelection
	$orderDishes:=This.orderDishes.query("dish.name = :1"; $orderDish.dish)
	If ($orderDishes.length#0)
		$status:=$orderDishes.drop()
		If ($status.length=0)
			Web Form.setMessage("Removed!")
		Else 
			Web Form.setError("Error")
		End if 
	End if 
	return This.groupedOrderDishes()
	
	
Class extends Entity


exposed Function get totalPrice() : Integer
	return ((This:C1470.dish.price#0) && (This:C1470.quantity)) ? This:C1470.dish.price*This:C1470.quantity : 0
	
	//used to increment/decrement dish quantities for the current order
exposed Function incrementQuantity()
	var $saved : Object
	This:C1470.quantity+=1
	$saved:=This:C1470.save()
	If ($saved.success)
		Web Form:C1735.setMessage("Incremented!")
	Else 
		Web Form:C1735.setError("Not Incremented!")
	End if 
	
exposed Function decrementQuantity()
	var $saved : Object
	This:C1470.quantity-=1
	$saved:=This:C1470.save()
	If ($saved.success)
		Web Form:C1735.setMessage("Decremented!")
		If (This:C1470.quantity=0)
			$saved:=This:C1470.drop()
			If ($saved.success)
				Web Form:C1735.setMessage("Dish removed from order!")
			Else 
				Web Form:C1735.setMessage("Error in quantity=0!")
			End if 
		End if 
	Else 
		Web Form:C1735.setError("Not decremented!")
	End if 
	
	
exposed Function create($newOrder : cs:C1710.OrderEntity)
	var $saved : Object
	var $orderLength : Integer
	If (Not:C34(ds:C1482.requiredField(This:C1470.dish.UUID; "orderDish")) & (Not:C34(ds:C1482.requiredField(This:C1470.quantity; "orderQuantity"))) & (This:C1470.quantity>0) & (This:C1470.quantity#0))
		This:C1470.order:=$newOrder
		$saved:=This:C1470.save()
		$newOrder.decrementQuantity()
		If ($saved.success)
			Web Form:C1735.setMessage("The dish was successfully added to the order !")
			Web Form:C1735["newOrderDish"].hide()
			ds:C1482.removeCss("orderedDishes"; "visibility")
		End if 
	Else 
		If ((This:C1470.quantity<0) || (This:C1470.quantity=0))
			Web Form:C1735.setError("The quantity should be positive and not null")
		Else 
			Web Form:C1735.setError("Fill the required fields!")
		End if 
	End if 
	ds:C1482.removeCss("newOrderTotal"; "visibility")
	
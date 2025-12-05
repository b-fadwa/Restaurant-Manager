Class extends Entity


exposed function get totalPrice() : integer
	return ((this.dish.price # 0) && (this.quantity)) ? this.dish.price*this.quantity : 0
	
exposed function incrementQuantity()
	var $saved: object
	this.quantity += 1
	$saved := this.save()
	if ($saved.success)
		web Form.setMessage("Incremented!")
	else 
		web Form.setError("Not Incremented!")
	end if 
	
exposed function decrementQuantity()
	var $saved: object
	this.quantity -= 1
	$saved := this.save()
	if ($saved.success)
		web Form.setMessage("Decremented!")
		if (this.quantity = 0)
			$saved := this.drop()
			if ($saved.success)
				web Form.setMessage("Dish removed from order!")
			else 
				web Form.setMessage("Error in quantity=0!")
			end if 
		end if 
	else 
		web Form.setError("Not decremented!")
	end if 
	
	
exposed function create($newOrder : cs.OrderEntity)
	var $saved: object
	var $orderLength: integer
	if (not(ds.requiredField(this.dish.UUID; "orderDish")) & (not(ds.requiredField(this.quantity; "orderQuantity"))) & (this.quantity > 0) & (this.quantity # 0))
		this.order := $newOrder
		$saved := this.save()
		$newOrder.decrementQuantity() 
		if ($saved.success)
			web Form.setMessage("The dish was successfully added to the order !")
			web Form["newOrderDish"].hide()
			ds.removeCss("orderedDishes"; "visibility")
			$orderLength := ds.Order.query("orderDate = :1"; current Date()).length
			if ($orderLength = 1)
				ds.noData($orderLength; "toHideWhenNoData"; "toShowWhenNoData")
			end if 
		end if 
	else 
		if ((this.quantity < 0) || (this.quantity = 0))
			web Form.setError("The quantity should be positive and not null")
		else 
			web Form.setError("Fill the required fields!")
		end if 
	end if
	ds.removeCss("newOrderTotal"; "visibility")

Class extends DataClass

exposed Function filterByDate($input : Variant) : cs:C1710.OrderSelection
	var $monthAtt : Object
	Case of 
		: ($input=1)
			return This:C1470.query("orderDate = :1"; Current date:C33())
		: ($input=2)
			return This:C1470.query("orderDate >= :1 and orderDate <= :2"; Current date:C33(); Add to date:C393(Current date:C33(); 0; 0; 7))
		: ($input=3)
			$monthAtt:=Formula:C1597((Month of:C24(This:C1470.orderDate)=Month of:C24(Current date:C33())) && (Year of:C25(This:C1470.orderDate)=Year of:C25(Current date:C33())))
			return This:C1470.query($monthAtt)
		: ($input=4)
			return This:C1470.query("orderDate >= :1 and orderDate <= :2"; Add to date:C393(Current date:C33(); 0; 0; -7); Current date:C33())
		Else 
	End case 
	
	
exposed Function getCurrentDateOrders() : cs:C1710.OrderSelection
	return This:C1470.query("orderDate = :1"; Current date:C33())
	
	
exposed Function filtering($dateSearch : Variant; $waiter : cs:C1710.WaiterEntity; $status : Variant) : cs:C1710.OrderSelection
	var $orders : cs:C1710.OrderSelection
	var $outputOrders : cs:C1710.OrderSelection
	Case of 
		: ((($dateSearch#0) && ($dateSearch#Null:C1517)) && ($waiter#Null:C1517) && (($status#"") && ($status#Null:C1517)))
			$orders:=This:C1470.filterByDate($dateSearch)
			$outputOrders:=This:C1470.query("waiter.user.fullName = :1 and status = :2"; $waiter.user.fullName; $status)
			$orders:=$orders.and($outputOrders)
			Web Form:C1735.setMessage("date+waiter+status "+String:C10($orders.length))
		: ((($dateSearch#0) && ($dateSearch#Null:C1517)) && (($waiter#Null:C1517)))  
			$orders:=This:C1470.filterByDate($dateSearch)
			$outputOrders:=This:C1470.query("waiter.user.fullName = :1"; $waiter.user.fullName)
			$orders:=$orders.and($outputOrders)
			Web Form:C1735.setMessage("date+waiter "+String:C10($orders.length))
		: ((($dateSearch#0) && ($dateSearch#Null:C1517)) && (($status#"") && ($status#Null:C1517)))  
			$orders:=This:C1470.filterByDate($dateSearch)
			$outputOrders:=This:C1470.query("status = :1"; $status)
			$orders:=$orders.and($outputOrders)
			Web Form:C1735.setMessage("date+status "+String:C10($orders.length))
		: (($waiter#Null:C1517) && (($status#"") && ($status#Null:C1517)))  
			$orders:=This:C1470.query("waiter.user.fullName = :1 and status = :2"; $waiter.user.fullName; $status)
			Web Form:C1735.setMessage("status+waiter "+String:C10($orders.length))
		: ((($dateSearch#0) && ($dateSearch#Null:C1517)))  
			$orders:=This:C1470.filterByDate($dateSearch)
			Web Form:C1735.setMessage("date "+String:C10($orders.length))
		: ($waiter#Null:C1517) 
			$orders:=This:C1470.query("waiter.user.fullName = :1"; $waiter.user.fullName)
			Web Form:C1735.setMessage("waiter "+String:C10($orders.length))
		: ((($status#"") && ($status#Null:C1517))) 
			$orders:=This:C1470.query("status = :1"; $status)
			Web Form:C1735.setMessage("status "+String:C10($orders.length))
		Else 
			$orders:=This:C1470.query("orderDate = :1"; Current date:C33())
			Web Form:C1735.setMessage("nothing "+String:C10($orders.length))
			ds:C1482.noData($orders.length; "toHideWhenNoData"; "toShowWhenNoData")
	End case 
	return $orders
	
exposed Function cancelOrder($UUID : Text)
	var $newOrder : cs:C1710.OrderEntity:=ds:C1482.Order.query("UUID = :1"; $UUID).first()
	var $status : Object
	var $orderDishes : cs:C1710.OrderDishSelection:=$newOrder.orderDishes
	If ($orderDishes.length#0)
		$newOrder.orderDishes.drop()
	End if 
	$status:=$newOrder.drop()
	If ($status.success)
		ds:C1482.setCss("orderedDishes"; "visibility")
		ds:C1482.setCss("newOrderTotal"; "visibility")
		ds:C1482.setCss("orderTable"; "visibility")
		ds:C1482.setCss("orderName"; "visibility")
		Web Form:C1735.setMessage("Order canceled!")
	Else 
		Web Form:C1735.setError("Error!")
	End if 
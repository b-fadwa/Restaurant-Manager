Class extends DataClass

exposed Function filterByDate($input : Integer) : cs.OrderSelection
	var $monthAtt : Object
	Case of 
		: ($input=1)
			return This.query("orderDate = :1"; Current date())
		: ($input=2)
			return This.query("orderDate >= :1 and orderDate <= :2"; Current date(); Add to date(Current date(); 0; 0; 7))
		: ($input=3)
			$monthAtt:=Formula((Month of(This.orderDate):=Month of(Current date())) && (Year of(This.orderDate):=Year of(Current date())))
			return This.query($monthAtt)
		: ($input=4)
			return This.query("orderDate >= :1 and orderDate <= :2"; Add to date(Current date(); 0; 0; -7); Current date())
		Else 
			// return this.all()
	End case 
	
	
	
exposed Function filtering($dateSearch : Variant; $waiter : cs.WaiterEntity; $status : Variant) : cs.OrderSelection
	var $orders : cs.OrderSelection
	var $outputOrders : cs.OrderSelection
	Case of 
		: ((($dateSearch#0) && ($dateSearch#Null)) && ($waiter#Null) && (($status#"") && ($status#Null)))
			$orders:=This.filterByDate($dateSearch)
			$outputOrders:=This.query("waiter.user.fullName = :1 and status = :2"; $waiter.user.fullName; $status)
			$orders:=$orders.and($outputOrders)
			Web Form.setMessage("date+waiter+status "+String($orders.length))
		: ((($dateSearch#0) && ($dateSearch#Null)) && (($waiter#Null)))  //filtering by date and $waiter
			$orders:=This.filterByDate($dateSearch)
			$outputOrders:=This.query("waiter.user.fullName = :1"; $waiter.user.fullName)
			$orders:=$orders.and($outputOrders)
			Web Form.setMessage("date+waiter "+String($orders.length))
		: ((($dateSearch#0) && ($dateSearch#Null)) && (($status#"") && ($status#Null)))  //filtering by date and $status
			$orders:=This.filterByDate($dateSearch)
			$outputOrders:=This.query("status = :1"; $status)
			$orders:=$orders.and($outputOrders)
			Web Form.setMessage("date+status "+String($orders.length))
		: (($waiter#Null) && (($status#"") && ($status#Null)))  //filtering by $waiter and $status
			$orders:=This.query("waiter.user.fullName = :1 and status = :2"; $waiter.user.fullName; $status)
			Web Form.setMessage("status+waiter "+String($orders.length))
		: ((($dateSearch#0) && ($dateSearch#Null)))  //filtering by date
			$orders:=This.filterByDate($dateSearch)
			Web Form.setMessage("date "+String($orders.length))
		: ($waiter#Null)  //$waiter 
			$orders:=This.query("waiter.user.fullName = :1"; $waiter.user.fullName)
			Web Form.setMessage("waiter "+String($orders.length))
		: ((($status#"") && ($status#Null)))  //filtering by $status
			$orders:=This.query("status = :1"; $status)
			Web Form.setMessage("status "+String($orders.length))
		Else 
			$orders:=This.query("orderDate = :1"; Current date())
			Web Form.setMessage("nothing "+String($orders.length))
			ds.noData($orders.length; "toHideWhenNoData"; "toShowWhenNoData")
	End case 
	return $orders
	
exposed Function cancelOrder($UUID : Text)
	var $newOrder : cs.OrderEntity:=ds.Order.query("UUID = :1"; $UUID).first()
	var $status : Object
	var $orderDishes : cs.OrderDishSelection:=$newOrder.orderDishes
	If ($orderDishes.length#0)
		$newOrder.orderDishes.drop()
	End if 
	$status:=$newOrder.drop()
	If ($status.success)
		ds.setCss("orderedDishes"; "visibility")
		ds.setCss("newOrderTotal"; "visibility")
		ds.setCss("orderTable"; "visibility")
		ds.setCss("orderName"; "visibility")
		Web Form.setMessage("Order canceled!")
	Else 
		Web Form.setError("Error!")
	End if 
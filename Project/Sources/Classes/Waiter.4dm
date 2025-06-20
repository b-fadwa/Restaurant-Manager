Class extends DataClass
	
exposed function waiters() : cs.WaiterSelection
	var $actualWaiters: cs.WaiterSelection := this.query("user.role = 'Waiter'")	
	if ($actualWaiters.length # 0) 
		return $actualWaiters
	else 
		return this.all()
	end if 

Class extends Entity


exposed function get totalPrice():Integer
	return this.orders.sum("totalPrice")
Class extends DataClass

//filter suppliers by product
exposed Function filter($param : cs:C1710.ProductEntity) : cs:C1710.SupplierSelection
	If ($param#Null:C1517)
		return ds:C1482.Supplier.query("productSuppliers.product.UUID = :1"; $param.UUID)
	Else 
		return ds:C1482.Supplier.all()
	End if 
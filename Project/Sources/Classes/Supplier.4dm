Class extends DataClass


exposed Function filter($param : cs.ProductEntity) : cs.SupplierSelection
	If ($param = Null)
		return ds.Supplier.all()
	Else
		return ds.Supplier.query("productSuppliers.product.UUID = :1"; $param.UUID)
	End if
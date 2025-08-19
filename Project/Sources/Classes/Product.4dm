Class extends DataClass

exposed Function filter($param : cs.CategoryEntity) : cs.ProductSelection
	If ($param = Null)
		return ds.Product.all()
	Else
		return ds.Product.query("category.UUID = :1"; $param.UUID)
	End if

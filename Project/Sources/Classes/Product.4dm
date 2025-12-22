Class extends DataClass

//search products by category
exposed Function filter($param : cs:C1710.CategoryEntity) : cs:C1710.ProductSelection
	If ($param#Null:C1517)
		return ds:C1482.Product.query("category.UUID = :1"; $param.UUID)
	Else 
		return ds:C1482.Product.all()
	End if 
	
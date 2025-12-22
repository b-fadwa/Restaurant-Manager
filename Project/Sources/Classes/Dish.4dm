Class extends DataClass

//searching by section UUID
exposed Function filter($param : cs:C1710.MenuSectionEntity) : cs:C1710.DishSelection
	If ($param#Null:C1517)
		return ds:C1482.Dish.query("section.UUID = :1"; $param.UUID)
	Else 
		return ds:C1482.Dish.all()
	End if 
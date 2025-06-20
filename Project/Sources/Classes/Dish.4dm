Class extends DataClass


exposed Function filter($param : cs.MenuSectionEntity): cs.DishSelection
	If ($param = Null)
		return ds.Dish.all()
	Else
		return ds.Dish.query("section.UUID = :1"; $param.UUID)
	End if
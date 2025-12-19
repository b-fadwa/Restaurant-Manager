Class extends DataClass

exposed Function search($search : Text) : cs:C1710.MenuSectionSelection
	If ($search#Null:C1517)
		return This:C1470.query("name = :1"; "@"+$search+"@")
	Else 
		return This:C1470.all()
	End if 
	
	
	
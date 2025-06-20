Class extends Entity

// add new ingredient to a dish
exposed Function setDish($selectedDish : cs:C1710.DishEntity)
	var $saved : Object
	This:C1470.dish:=$selectedDish
	$saved:=This:C1470.save()
	If ($saved.success)
		Web Form:C1735.setMessage("Ingredient added successfully !")
	Else 
		Web Form:C1735.setError("Addition Failed !")
	End if 
Class extends EntitySelection

// Returning a new dish selection by adding/removing the given dishes to the current selection.
exposed Function addToList($dishSelection : cs:C1710.DishSelection) : cs:C1710.DishSelection
	var $selection : cs:C1710.DishSelection
	var $dish : cs:C1710.DishEntity
	$selection:=This:C1470.copy()
	For each ($dish; $dishSelection)
		$selection.add($dish)
	End for each 
	return $selection
	
exposed Function removeFromList($dishSelection : cs:C1710.DishSelection) : cs:C1710.DishSelection
	var $selection : cs:C1710.DishSelection
	$selection:=This:C1470.copy()
	return $selection.minus($dishSelection)
Class extends EntitySelection

exposed function addToList($dishSelection : cs.DishSelection):cs.DishSelection
	var $selection: cs.DishSelection
	var $dish:cs.DishEntity
	$selection := this.copy()
	for Each($dish; $dishSelection)
		$selection.add($dish)
	end for each
	return $selection

exposed function removeFromList($dishSelection : cs.DishSelection):cs.DishSelection
	var $selection: cs.DishSelection
	$selection := this.copy()
	return $selection.minus($dishSelection)
Class extends Entity


exposed function createFullSection() : cs.MenuSectionEntity
	var $saved: object
	if (ds.requiredField(this.name; "menuName"))
		web Form.setError("Give a name to your menu first!")
	else 
		$saved := this.save()
		ds.removeCss("newDishSection"; "visibility")
	end if 
	return this

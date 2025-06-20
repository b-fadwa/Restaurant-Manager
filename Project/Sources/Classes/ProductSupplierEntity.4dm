Class extends Entity

exposed function create($newSupplier : cs.SupplierEntity) 
	var $saved: object
	this.supplier := $newSupplier
	$saved := this.save()
	if ($saved.success)
		web Form.setMessage("The Product was successfully added to the Supplier Products !")
		ds.removeCss("proposedProducts"; "visibility")
	else 
		web Form.setError("Cannot add product to supplier !")
	end if 
	

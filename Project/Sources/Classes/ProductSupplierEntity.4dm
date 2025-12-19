Class extends Entity

exposed Function create($newSupplier : cs:C1710.SupplierEntity)
	var $saved : Object
	This:C1470.supplier:=$newSupplier
	$saved:=This:C1470.save()
	If ($saved.success)
		Web Form:C1735.setMessage("The Product was successfully added to the Supplier Products !")
		ds:C1482.removeCss("proposedProducts"; "visibility")
	Else 
		Web Form:C1735.setError("Cannot add product to supplier !")
	End if 
	
	
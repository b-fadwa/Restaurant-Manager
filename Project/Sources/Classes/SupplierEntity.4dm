Class extends Entity


alias soldCategory productSuppliers.product.category


exposed function updateSupplier($street : text; $city : text; $state : text; $zip : text; $phone : text; $email : text) : cs.SupplierEntity
	var $saved: object
	this.address := new Object("street"; $street; "city"; $city; "state"; $state; "zip"; $zip)
	this.contactInfo := new Object("Phone"; $phone; "Email"; $email)
	
	$saved := this.save()
	if ($saved.success)
		web Form.setMessage("Supplier was updated successfully !")
		ds.removeCss("proposedProducts"; "visibility")
		return this
	else 
		web Form.setError("Update Failed !")
		return this
	end if 
	
exposed function createFullSupplier($street : text; $city : text; $state : text; $zip : text; $phone : text; $email : text) : cs.SupplierEntity
	var $saved: object
	trace
	this.address := new Object("street"; $street; "city"; $city; "state"; $state; "zip"; $zip)
	this.contactInfo := new Object("Phone"; $phone; "Email"; $email)
	if ((not(ds.requiredField(this.name; "supplierName"))) & (not(ds.requiredField(this.address.street; "supplierLocation"))) & (not(ds.requiredField(this.contactInfo.Phone; "supplierPhone"))))
		$saved := this.save()
		if ($saved.success)
			web Form.setMessage("Supplier was created successfully !")
			return ds.Supplier.new()
		else 
			web Form.setError("Saving Failed !")
			return this
		end if 
	else 
		web Form.setError("Fill the required fields !")
		return this
	end if
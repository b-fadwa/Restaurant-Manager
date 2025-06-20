Class extends Entity

exposed function dropDishProducts()  
	var $saved: object
	$saved := this.dishProducts.drop()
	if ($saved.length = 0)
		web Form.setMessage("dishProducts removed!!!!")
	else 
		web Form.setError("dishProducts not removed!!!!")
	end if 
	
	
	
exposed function createfullProduct() : cs.ProductEntity
	var $saved: object
	if (not(ds.requiredField(this.name; "productName")) & not(ds.requiredField(this.category.name; "productCategory")) & \
		not(ds.requiredField(this.availableQuantity; "productQuantity")) & not(ds.requiredField(this.price; "productPrice")) & not(ds.requiredField(this.expirationDate; "productDate")))
		$saved := this.save()
		if ($saved.success)
			web Form.setMessage("Product created successfully, Check the selectbox to link it with your supplier!")
			webform["newProduct"].hide()
			return ds.Product.new()
		else 
			web Form.setError("Saving failed!!")
		end if 
	else 
		web Form.setError("Fill the required fields!")
		return this
	end if 

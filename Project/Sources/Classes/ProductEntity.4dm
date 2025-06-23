Class extends Entity

exposed Function dropDishProducts()
	var $saved : Object
	$saved:=This.dishProducts.drop()
	If ($saved.length=0)
		Web Form.setMessage("dishProducts removed!!!!")
	Else 
		Web Form.setError("dishProducts not removed!!!!")
	End if 
	
	
	
exposed Function createfullProduct() : cs.ProductEntity
	var $saved : Object
	If (Not(ds.requiredField(This.name; "productName")) & Not(ds.requiredField(This.category.name; "productCategory")) & \
		Not(ds.requiredField(This.availableQuantity; "productQuantity")) & Not(ds.requiredField(This.price; "productPrice")) & Not(ds.requiredField(This.expirationDate; "productDate")))
		$saved:=This.save()
		If ($saved.success)
			Web Form.setMessage("Product created successfully, Check the selectbox to link it with your supplier!")
			Web Form:C1735["newProduct"].hide()
			return ds.Product.new()
		Else 
			Web Form.setError("Saving failed!!")
		End if 
	Else 
		Web Form.setError("Fill the required fields!")
		return This
	End if 
	
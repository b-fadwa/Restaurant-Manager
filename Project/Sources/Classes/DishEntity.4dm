Class extends Entity

exposed Function checkParams() : Boolean
	var $status : Boolean
	$status:=False:C215
	If (ds:C1482.requiredField(This:C1470.name; "dishName"))
		$status:=True:C214
	End if 
	If (ds:C1482.requiredField(This:C1470.description; "dishDescription"))
		$status:=True:C214
	End if 
	If (ds:C1482.requiredField(This:C1470.price; "dishPrice"))
		$status:=True:C214
	End if 
	return $status
	
	
exposed Function edit($protein : Integer; $carbs : Integer; $fat : Integer) : cs:C1710.DishEntity
	This:C1470.macros:=New object:C1471("Protein"; $protein; "Carbohydrates"; $carbs; "Fat"; $fat)
	var $isNotValid : Boolean
	var $saved : Object
	$isNotValid:=This:C1470.checkParams()
	If ($isNotValid=False:C215)
		If (This:C1470.price<0)
			Web Form:C1735.setError("The price must be positive!")
			return This:C1470
		Else 
			$saved:=This:C1470.save()
			If ($saved.success)
				Web Form:C1735.setMessage("This dish was updated successfully !")
				Web Form:C1735["dishPrice"].removeCSSClass("requiredField")
				return This:C1470
			End if 
		End if 
	Else 
		Web Form:C1735.setError("Update Failed !")
		return This:C1470
		Web Form:C1735.setError("Please Fill all the fields !")
	End if 
	
exposed Function create($protein : Integer; $carbs : Integer; $fat : Integer) : cs:C1710.DishEntity
	This:C1470.macros:=New object:C1471("Protein"; $protein; "Carbohydrates"; $carbs; "Fat"; $fat)
	var $saved : Object
	If (Not:C34(This:C1470.checkParams()))
		If (This:C1470.price<0)
			Web Form:C1735.setError("The price must be positive!")
			return This:C1470
		Else 
			$saved:=This:C1470.save()
			If ($saved.success)
				Web Form:C1735.setMessage("This dish was created successfully !")
				Web Form:C1735.newEmptyDish.hide()
				Web Form:C1735.sideBar.addCSSClass("visibility")
				return ds:C1482.Dish.new()
			Else 
				Web Form:C1735.setError("Creation Failed !")
				return This:C1470
			End if 
		End if 
	Else 
		Web Form:C1735.setError("Please Fill all the fields !")
		return This:C1470
	End if 
	
	
exposed Function addToMenu($selectedMenuSection : cs:C1710.MenuSectionEntity)
	var $isSaved : Object
	This:C1470.section:=$selectedMenuSection
	$isSaved:=This:C1470.save()
	If ($isSaved.success)
		$selectedMenuSection.reload()
		Web Form:C1735.setMessage("This dish was added successfully to this section!")
	Else 
		Web Form:C1735.setError("Error occured!")
	End if 
	
exposed Function dropDishProducts()  //used in drop dish
	var $saved : Object
	$saved:=This:C1470.dishProducts.drop()
	If ($saved.length=0)
		Web Form:C1735.setMessage("dishProducts removed!!!!")
	Else 
		Web Form:C1735.setError("dishProducts not removed!!!!")
	End if 
	
	
exposed Function removeSection() : cs:C1710.DishEntity
	var $isDropped : Object
	This:C1470.section:=Null:C1517
	$isDropped:=This:C1470.save()
	If ($isDropped.success)
		Web Form:C1735.setMessage("Dish removed!")
	Else 
		Web Form:C1735.setError("Dish not removed!")
	End if 
	
exposed Function getExistingProducts() : cs:C1710.DishProductSelection
	return This:C1470.dishProducts.query("product.UUID #null")
Class extends DataStoreImplementation

exposed Function authentify($email : Text; $password : Text) : Boolean
	var $guestPrivs : Collection:=["guest"; "guestPromoted"]
	If (($email="") && ($password=""))
		return Session:C1714.setPrivileges($guestPrivs)
	End if 
	var $user : cs:C1710.UserEntity:=ds:C1482.User.query("mail = :1"; $email).first()
	var $chefPrivileges : Collection:=["manageUsers"; "manageDataStore"; "manageOrders"; "manageDishes"; "manageSections"; "manageProducts"; "login"]
	var $waiterPrivileges : Collection:=["manageUsers"; "manageDataStore"; "manageOrders"; "login"]
	var $adminPrivileges : Collection:=["manageUsers"; "manageDataStore"; "manageOrders"; "manageDishes"; "manageSections"; "manageProducts"; "manageSuppliers"; "login"]
	
	If ($user#Null:C1517)
		If (Verify password hash:C1534($password; $user.password))
			Use (Session:C1714.storage)
				Session:C1714.storage.payLoad:=New shared object:C1526("UUID"; $user.UUID; "login"; $user.mail)
			End use 
			Case of 
				: ($user.role="chef")
					return Session:C1714.setPrivileges($chefPrivileges)
				: ($user.role="Waiter")
					return Session:C1714.setPrivileges($waiterPrivileges)
				: ($user.role="Admin")
					return Session:C1714.setPrivileges($adminPrivileges)
			End case 
			Web Form:C1735.setMessage("Authentication successful")
			
		Else 
			Web Form:C1735.setError("Authentication failed")
		End if 
	Else 
		Web Form:C1735.setError("Authentication failed")
	End if 
	
exposed Function setCss($serverRef : Text; $cssClass : Text)
	var $component : 4D:C1709.WebFormItem
	$component:=Web Form:C1735[$serverRef]
	$component.addCSSClass($cssClass)
	
exposed Function removeCss($serverRef : Text; $cssClass : Text)
	var $component : 4D:C1709.WebFormItem
	$component:=Web Form:C1735[$serverRef]
	$component.removeCSSClass($cssClass)
	
	
exposed Function navbar($serverRef : Text)
	var $component : 4D:C1709.WebFormItem
	Web Form:C1735[$serverRef].addCSSClass("navButtonColor")
	Case of 
		: ($serverRef="sectionNav")
			Web Form:C1735["dishNav"].removeCSSClass("navButtonColor")
			Web Form:C1735["stockNav"].removeCSSClass("navButtonColor")
			Web Form:C1735["orderNav"].removeCSSClass("navButtonColor")
		: ($serverRef="dishNav")
			Web Form:C1735["stockNav"].removeCSSClass("navButtonColor")
			Web Form:C1735["orderNav"].removeCSSClass("navButtonColor")
			Web Form:C1735["sectionNav"].removeCSSClass("navButtonColor")
		: ($serverRef="stockNav")
			Web Form:C1735["orderNav"].removeCSSClass("navButtonColor")
			Web Form:C1735["dishNav"].removeCSSClass("navButtonColor")
			Web Form:C1735["sectionNav"].removeCSSClass("navButtonColor")
		: ($serverRef="orderNav")
			Web Form:C1735["sectionNav"].removeCSSClass("navButtonColor")
			Web Form:C1735["dishNav"].removeCSSClass("navButtonColor")
			Web Form:C1735["stockNav"].removeCSSClass("navButtonColor")
	End case 
	
	
exposed Function requiredField($input : Variant; $serverRef : Text) : Boolean  
	var $component : 4D:C1709.WebFormItem
	$component:=Web Form:C1735[$serverRef]
	Case of   		
		: ((Value type:C1509($input)=1) && ($input=Null:C1517))  
			$component.addCSSClass("requiredField")
			return True:C214
		: ((Value type:C1509($input)=3) && ($input=Null:C1517))  
			$component.addCSSClass("requiredField")
			return True:C214
		: ((Value type:C1509($input)=30) && ($input=Null:C1517))  
			$component.addCSSClass("requiredField")
			return True:C214
		: ((Value type:C1509($input)=2) && ($input=""))  
			$component.addCSSClass("requiredField")
			return True:C214
		: ((Value type:C1509($input)=4) && ($input=Date:C102(!00-00-00!)))  
			$component.addCSSClass("requiredField")
			return True:C214
		: ((Value type:C1509($input)=5) && (Undefined:C82($input)))  
			$component.addCSSClass("requiredField")
			return True:C214
		: ((Value type:C1509($input)=12) && ($input=Null:C1517))  
			$component.addCSSClass("requiredField")
			return True:C214
		: ((Value type:C1509($input)=6) && ($input=Null:C1517)) 
			$component.addCSSClass("requiredField")
			return True:C214
		: ((Value type:C1509($input)=255) && ($input=Null:C1517)) 
			$component.addCSSClass("requiredField")
			return True:C214
		Else 
			$component.removeCSSClass("requiredField")
			return False:C215
	End case 
	
exposed Function returnCurrentDate() : Date
	return Date:C102(Current date:C33())
	
exposed Function isDeliveryOrder($option : Text)
	If ($option="Delivery")
		ds:C1482.setCss("orderTable"; "visibility")
		ds:C1482.removeCss("orderName"; "visibility")
	Else 
		ds:C1482.setCss("orderName"; "visibility")
		ds:C1482.removeCss("orderTable"; "visibility")
	End if 
	
exposed Function manageRoles()
	Case of 
		: (Session:C1714.hasPrivilege("manageSections") && Session:C1714.hasPrivilege("manageProducts") && Session:C1714.hasPrivilege("manageSuppliers") && Session:C1714.hasPrivilege("manageDishes")\
			 && Session:C1714.hasPrivilege("manageOrders"))
			Web Form:C1735.setMessage("Super-admin !")
		: (Session:C1714.hasPrivilege("manageOrders") && Not:C34(Session:C1714.hasPrivilege("manageProducts")) && Not:C34(Session:C1714.hasPrivilege("manageDishes"))\
			 && Not:C34(Session:C1714.hasPrivilege("manageSuppliers")) && Not:C34(Session:C1714.hasPrivilege("manageSections")))
			This:C1470.setCss("orderNav"; "visibility")
			This:C1470.setCss("stockNav"; "visibility")
			This:C1470.setCss("sectionNav"; "visibility")
			This:C1470.setCss("dishNav"; "visibility")
			Web Form:C1735.setMessage("Waiter!")
		: (Session:C1714.hasPrivilege("manageSections") && Session:C1714.hasPrivilege("manageOrders") && Session:C1714.hasPrivilege("manageDishes") && Session:C1714.hasPrivilege("manageProducts")\
			 && Not:C34(Session:C1714.hasPrivilege("manageSuppliers")))
			This:C1470.setCss("stockNav"; "visibility")
			Web Form:C1735.setMessage("Chef!")
		Else 
			Web Form:C1735.setError("No permission!")
	End case 
	
exposed Function noData($selectionLength : Variant; $toHidePart : Text; $toShowPart : Text)
	If ($selectionLength=0)
		Web Form:C1735[$toHidePart].hide()
		Web Form:C1735[$toShowPart].show()
	Else 
		Web Form:C1735[$toHidePart].show()
		Web Form:C1735[$toShowPart].hide()
	End if 
	
exposed Function getManifestObject() : Object
	var $manifestFile : 4D:C1709.File
	var $manifestObject : Object
	$manifestFile:=File:C1566("/PACKAGE/Project/Sources/Shared/manifest.json")
	$manifestObject:=JSON Parse:C1218($manifestFile.getText())
	return $manifestObject
	
	
exposed Function generateData()
	var $newData : cs:C1710.initData:=cs:C1710.initData.new()
	$newData.dropData()
	$newData.createData()
	Web Form:C1735.setMessage("Data generated!")
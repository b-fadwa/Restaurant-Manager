Class extends DataStoreImplementation

exposed Function authentify($email : Text; $password : Text) : Boolean
	trace
	var $user : cs.UserEntity:=ds.User.query("mail = :1"; $email).first()
	var $chefPrivileges:collection:=["manageUsers";"manageDataStore"; "manageOrders"; "manageDishes"; "manageSections";"manageProducts";"login"]
	var $waiterPrivileges:collection:=["manageUsers"; "manageDataStore";"manageOrders";"login"]
	var $adminPrivileges:collection:=["manageUsers";"manageDataStore"; "manageOrders"; "manageDishes"; "manageSections";"manageProducts";"manageSuppliers";"login"]
	If ($user#Null)
		If (Verify password hash($password; $user.password))
			Use (Session.storage)
				Session.storage.payLoad:=New shared object("UUID"; $user.UUID; "login"; $user.mail)
			End use 
			Case of 
				: ($user.role="chef")
					return Session.setPrivileges($chefPrivileges)
				: ($user.role="Waiter")
					return Session.setPrivileges($waiterPrivileges)
				: ($user.role="Admin")
					return Session.setPrivileges($adminPrivileges)
			End case 
			Web Form.setMessage("Authentication successful")
			
		Else 
			Web Form.setError("Authentication failed")
		End if 
	Else 
		Web Form.setError("Authentication failed")
	End if 

exposed function setCss($serverRef : text; $cssClass : text)
	var $component: 4D.WebFormItem
	$component := web Form[$serverRef]
	$component.addCSSClass($cssClass)
	
exposed function removeCss($serverRef : text; $cssClass : text)
	var $component: 4D.WebFormItem
	$component := web Form[$serverRef]
	$component.removeCSSClass($cssClass)
	
	
exposed function navbar($serverRef : text) 
	var $component: 4D.WebFormItem
	web Form[$serverRef].addCSSClass("navButtonColor")
	case of 
		: ($serverRef = "sectionNav")
			web Form["dishNav"].removeCSSClass("navButtonColor")
			web Form["stockNav"].removeCSSClass("navButtonColor")
			web Form["orderNav"].removeCSSClass("navButtonColor")
		: ($serverRef = "dishNav")
			web Form["stockNav"].removeCSSClass("navButtonColor")
			web Form["orderNav"].removeCSSClass("navButtonColor")
			web Form["sectionNav"].removeCSSClass("navButtonColor")
		: ($serverRef = "stockNav")
			web Form["orderNav"].removeCSSClass("navButtonColor")
			web Form["dishNav"].removeCSSClass("navButtonColor")
			web Form["sectionNav"].removeCSSClass("navButtonColor")
		: ($serverRef = "orderNav")
			web Form["sectionNav"].removeCSSClass("navButtonColor")
			web Form["dishNav"].removeCSSClass("navButtonColor")
			web Form["stockNav"].removeCSSClass("navButtonColor")
	end case 
	
	
exposed function requiredField($input : variant; $serverRef : text) : boolean  //used to make an empty field required
	var $component: 4D.WebFormItem
	$component := web Form[$serverRef]
	case of   //check type first and then do the treatment		
		: ((Value type($input) = 1) && ($input = null))  //integer
			$component.addCSSClass("requiredField")
			return true
		: ((Value type($input) = 3) && ($input = null))  //picture
			$component.addCSSClass("requiredField")
			return true
		: ((Value type($input) = 30) && ($input = null))  //blob
			$component.addCSSClass("requiredField")
			return true
		: ((Value type($input) = 2) && ($input = ""))  //string
			$component.addCSSClass("requiredField")
			return true
		: ((Value type($input) = 4) && ($input = date(!00-00-00!)))  //date
			$component.addCSSClass("requiredField")
			return true
		: ((Value type($input) = 5) && (undefined($input)))  //undefined
			$component.addCSSClass("requiredField")
			return true
		: ((Value type($input) = 12) && ($input = null))  //variant
			$component.addCSSClass("requiredField")
			return true
		: ((Value type($input) = 6) && ($input = null))  //boolean
			$component.addCSSClass("requiredField")
			return true
		: ((Value type($input) = 255) && ($input = null))  //null
			$component.addCSSClass("requiredField")
			return true
		else 
			$component.removeCSSClass("requiredField")
			return false
	end case 
	
exposed function returnCurrentDate() : date
	return date(current Date())
	
exposed function isDeliveryOrder($option : text)  
	if ($option = "Delivery")
		ds.setCss("orderTable"; "visibility")
		ds.removeCss("orderName"; "visibility")
	else 
		ds.setCss("orderName"; "visibility")
		ds.removeCss("orderTable"; "visibility")
	end if 
	
exposed function manageRoles()  
	case of 
			//super-admin
		: (session.hasPrivilege("manageSections") && session.hasPrivilege("manageProducts") && session.hasPrivilege("manageSuppliers") && session.hasPrivilege("manageDishes")\
			 && session.hasPrivilege("manageOrders"))
			web Form.setMessage("Super-admin !")
			// waiter
		: (session.hasPrivilege("manageOrders") && not(session.hasPrivilege("manageProducts")) && not(session.hasPrivilege("manageDishes"))\
			 && not(session.hasPrivilege("manageSuppliers")) && not(session.hasPrivilege("manageSections")))
			this.setCss("orderNav"; "visibility")
			this.setCss("stockNav"; "visibility")
			this.setCss("sectionNav"; "visibility")
			this.setCss("dishNav"; "visibility")
			web Form.setMessage("Waiter!")
			//chef
		: (session.hasPrivilege("manageSections") && session.hasPrivilege("manageOrders") && session.hasPrivilege("manageDishes") && session.hasPrivilege("manageProducts")\
			 && not(session.hasPrivilege("manageSuppliers")))
			this.setCss("stockNav"; "visibility")
			web Form.setMessage("Chef!")
		else 
			web Form.setError("No permission!")
	end case 
	
exposed function noData($selectionLength : variant; $toHidePart : text; $toShowPart : text)  
	if ($selectionLength = 0)
		web Form[$toHidePart].hide()
		web Form[$toShowPart].show()
	else 
		web Form[$toHidePart].show()
		web Form[$toShowPart].hide()
	end if 
	
exposed function getManifestObject() : object 
	var $manifestFile: 4D.File
	var $manifestObject: object
	$manifestFile := file("/PACKAGE/Project/Sources/Shared/manifest.json")
	$manifestObject := JSON Parse($manifestFile.getText())
	return $manifestObject
	
	
exposed function generateData()
	var $newData: cs.initData := cs.initData.new()
	// drop DATA
	$newData.dropData()
	// init DATA
	$newData.createData()
	web Form.setMessage("Data generated!")
Class constructor
	
	
	
Function dropData()
	var $trash : Object
	$trash:=ds:C1482.User.all().drop()
	$trash:=ds:C1482.Waiter.all().drop()
	$trash:=ds:C1482.Order.all().drop()
	$trash:=ds:C1482.Table.all().drop()
	$trash:=ds:C1482.MenuSection.all().drop()
	$trash:=ds:C1482.Dish.all().drop()
	$trash:=ds:C1482.Product.all().drop()
	$trash:=ds:C1482.Facture.all().drop()
	$trash:=ds:C1482.Supplier.all().drop()
	$trash:=ds:C1482.Category.all().drop()
	$trash:=ds:C1482.OrderDish.all().drop()
	$trash:=ds:C1482.DishProduct.all().drop()
	$trash:=ds:C1482.ProductSupplier.all().drop()
	
	
Function createData()
	This:C1470.generateUsers()
	This:C1470.generateWaiter()
	This:C1470.generateTable()
	This:C1470.generateFacture()
	This:C1470.generateCategory()
	This:C1470.generateProduct()
	This:C1470.generateSupplier()
	This:C1470.generateMenu()
	This:C1470.generateDish()
	This:C1470.generateOrder()
	This:C1470.generateOrdersDish()
	This:C1470.generateDishProduct()
	This:C1470.generateProductSupplier()
	This:C1470.generateDishesWithNoSection()
	
Function generateUsers()
	var $users : Collection:=[\
		{firstName: "John"; lastName: "Smith"; password: "a1b2c3"; email: "john.smith@example.com"; role: "Admin"}; \
		{firstName: "Alice"; lastName: "Johnson"; password: "d4e5f6"; email: "alice.johnson@example.com"; role: "Chef"}; \
		{firstName: "Robert"; lastName: "Brown"; password: "g7h8i9"; email: "robert.brown@example.com"; role: "Waiter"}; \
		{firstName: "Emily"; lastName: "Davis"; password: "j0k1l2"; email: "emily.davis@example.com"; role: "Waiter"}; \
		{firstName: "Michael"; lastName: "Miller"; password: "m3n4o5"; email: "michael.miller@example.com"; role: "Waiter"}; \
		{firstName: "Sarah"; lastName: "Wilson"; password: "p6q7r8"; email: "sarah.wilson@example.com"; role: "Waiter"}; \
		{firstName: "David"; lastName: "Moore"; password: "s9t0u1"; email: "david.moore@example.com"; role: "Waiter"}; \
		{firstName: "Laura"; lastName: "Taylor"; password: "v2w3x4"; email: "laura.taylor@example.com"; role: "Admin"}; \
		{firstName: "Daniel"; lastName: "Anderson"; password: "y5z6a7"; email: "daniel.anderson@example.com"; role: "Admin"}; \
		{firstName: "Jessica"; lastName: "Thomas"; password: "b8c9d0"; email: "jessica.thomas@example.com"; role: "Admin"}; \
		{firstName: "Matthew"; lastName: "Jackson"; password: "e1f2g3"; email: "matthew.jackson@example.com"; role: "Admin"}; \
		{firstName: "Olivia"; lastName: "White"; password: "h4i5j6"; email: "olivia.white@example.com"; role: "Admin"}; \
		{firstName: "Andrew"; lastName: "Harris"; password: "k7l8m9"; email: "andrew.harris@example.com"; role: "Chef"}; \
		{firstName: "Sophia"; lastName: "Martin"; password: "n0o1p2"; email: "sophia.martin@example.com"; role: "Chef"}; \
		{firstName: "Christopher"; lastName: "Thompson"; password: "q3r4s5"; email: "christopher.thompson@example.com"; role: "Waiter"}; \
		{firstName: "Emma"; lastName: "Garcia"; password: "t6u7v8"; email: "emma.garcia@example.com"; role: "Admin"}; \
		{firstName: "Anthony"; lastName: "Martinez"; password: "w9x0y1"; email: "anthony.martinez@example.com"; role: "Admin"}; \
		{firstName: "Isabella"; lastName: "Robinson"; password: "z2a3b4"; email: "isabella.robinson@example.com"; role: "Admin"}; \
		{firstName: "Joshua"; lastName: "Clark"; password: "c5d6e7"; email: "joshua.clark@example.com"; role: "Waiter"}; \
		{firstName: "Mia"; lastName: "Rodriguez"; password: "f8g9h0"; email: "mia.rodriguez@example.com"; role: "Waiter"}\
		]
	
	var $user : Object
	var $newUser : cs:C1710.UserEntity
	
	For each ($user; $users)
		$newUser:=ds:C1482.User.new()
		$newUser.firstName:=$user.firstName
		$newUser.lastName:=$user.lastName
		$newUser.password:=Generate password hash:C1533($user.password)
		$newUser.mail:=$user.email
		$newUser.role:=$user.role
		$newUser.save()
	End for each 
	
	
Function generateCategory()
	var $categories : Collection
	var $item : Text
	var $category : cs:C1710.CategoryEntity
	var $info : Object
	
	$categories:=["Meat and Poultry and Eggs"; "Seafood"; "Dairy and Dairy Alternatives"; "Grains and Ceintegers"; "Fruits"; "Vegetables"; "Nuts and Seeds"; "Sweeteners"; "Oils and Fats"; "Herbs and Spices"; "Condiments and Sauces"]
	
	For each ($item; $categories)
		$category:=ds:C1482.Category.new()
		$category.name:=$item
		$category:=$category.save()
	End for each 
	
Function generateSupplier()
	var $suppliers : Collection
	var $supplier : cs:C1710.SupplierEntity
	var $item : Object
	var $info : Object
	
	$suppliers:=New collection:C1472()
	$suppliers.push(New object:C1471("Name"; "Ocean Fresh Seafood"; "contactInfo"; New object:C1471("Phone"; "888-222-3333"; "Email"; "info@oceanfreshseafood.com"); "address"; New object:C1471("street"; "234 Ocean Ave"; "city"; "Seafood City"; "state"; "State"; "zip"; "24680")); \
		New object:C1471("Name"; "Meat Master Inc."; "contactInfo"; New object:C1471("Phone"; "444-666-7777"; "Email"; "info@meatmaster.com"); "address"; New object:C1471("street"; "567 Butcher Block"; "city"; "Meatville"; "state"; "State"; "zip"; "97531")); \
		New object:C1471("Name"; "Gourmet Grocers Ltd."; "contactInfo"; New object:C1471("Phone"; "111-333-5555"; "Email"; "info@gourmetgrocers.com"); "address"; New object:C1471("street"; "789 Gourmet St"; "city"; "Delightville"; "state"; "State"; "zip"; "54321")); \
		New object:C1471("Name"; "Fresh Fruit Farms"; "contactInfo"; New object:C1471("Phone"; "777-999-1111"; "Email"; "info@freshfruitfarms.com"); "address"; New object:C1471("street"; "222 Fruit St"; "city"; "Orchardville"; "state"; "State"; "zip"; "78965")); \
		New object:C1471("Name"; "Green Leaf Vegetables"; "contactInfo"; New object:C1471("Phone"; "555-888-9999"; "Email"; "info@greenleafveggies.com"); "address"; New object:C1471("street"; "333 Veggie Blvd"; "city"; "Greensville"; "state"; "State"; "zip"; "45678")))
	For each ($item; $suppliers)
		$supplier:=ds:C1482.Supplier.new()
		$supplier.name:=$item.Name
		$supplier.contactInfo:=$item.contactInfo
		$supplier.address:=$item.address
		$supplier.description:=$item.Name+" is a major foodservice distributor with an annual revenue of $28.1 billion. Headquartered in "+$item.address.city+". The company serves over 300;000 customers and operates more than 70 distribution facilities."
		$info:=$supplier.save()
	End for each 
	
Function generateProduct()
	var $products : Collection
	var $product : cs:C1710.ProductEntity
	var $item : Object
	var $info : Object
	var $categories : cs:C1710.CategorySelection
	var $i : Integer
	
	$categories:=ds:C1482.Category.all()
	$products:=New collection:C1472
	$products.push(New object:C1471("productName"; "Chicken Breast"; "price"; 3.99; "quantityAvailable"; 5000; "expirationDate"; "2025-12-31"; "barcode"; "123456789012"); \
		New object:C1471("productName"; "Tomatoes"; "price"; 1.49; "quantityAvailable"; 5000; "expirationDate"; "2025-12-15"; "barcode"; "234567890123"); \
		New object:C1471("productName"; "Pasta"; "price"; 2.29; "quantityAvailable"; 5000; "expirationDate"; "2025-01-10"; "barcode"; "345678901234"); \
		New object:C1471("productName"; "Beef Steak"; "price"; 5.99; "quantityAvailable"; 5000; "expirationDate"; "2025-12-28"; "barcode"; "456789012345"); \
		New object:C1471("productName"; "Lettuce"; "price"; 1.19; "quantityAvailable"; 5000; "expirationDate"; "2025-12-20"; "barcode"; "567890123456"); \
		New object:C1471("productName"; "Shrimp"; "price"; 6.49; "quantityAvailable"; 5000; "expirationDate"; "2025-12-25"; "barcode"; "678901234567"); \
		New object:C1471("productName"; "Mushrooms"; "price"; 2.99; "quantityAvailable"; 5000; "expirationDate"; "2025-12-18"; "barcode"; "789012345678"); \
		New object:C1471("productName"; "Onions"; "price"; 0.99; "quantityAvailable"; 5000; "expirationDate"; "2025-12-22"; "barcode"; "890123456789"); \
		New object:C1471("productName"; "Salmon Fillet"; "price"; 7.99; "quantityAvailable"; 5000; "expirationDate"; "2025-12-30"; "barcode"; "901234567890"); \
		New object:C1471("productName"; "Bell Peppers"; "price"; 1.29; "quantityAvailable"; 5000; "expirationDate"; "2025-12-18"; "barcode"; "012345678901"); \
		New object:C1471("productName"; "Cheese"; "price"; 4.49; "quantityAvailable"; 5000; "expirationDate"; "2025-12-29"; "barcode"; "123456789012"); \
		New object:C1471("productName"; "Eggs"; "price"; 1.89; "quantityAvailable"; 5000; "expirationDate"; "2025-12-25"; "barcode"; "234567890123"); \
		New object:C1471("productName"; "Rice"; "price"; 1.99; "quantityAvailable"; 5000; "expirationDate"; "2025-01-05"; "barcode"; "345678901234"); \
		New object:C1471("productName"; "Carrots"; "price"; 0.79; "quantityAvailable"; 5000; "expirationDate"; "2025-12-21"; "barcode"; "456789012345"); \
		New object:C1471("productName"; "Garlic"; "price"; 0.69; "quantityAvailable"; 5000; "expirationDate"; "2025-12-24"; "barcode"; "567890123456"); \
		New object:C1471("productName"; "Olive Oil"; "price"; 3.29; "quantityAvailable"; 5000; "expirationDate"; "2025-01-15"; "barcode"; "678901234567"); \
		New object:C1471("productName"; "Lemon"; "price"; 0.89; "quantityAvailable"; 5000; "expirationDate"; "2025-12-22"; "barcode"; "789012345678"); \
		New object:C1471("productName"; "Salt"; "price"; 0.49; "quantityAvailable"; 5000; "expirationDate"; "2025-01-01"; "barcode"; "890123456789"); \
		New object:C1471("productName"; "Black Pepper"; "price"; 0.59; "quantityAvailable"; 5000; "expirationDate"; "2025-02-01"; "barcode"; "901234567890"); \
		New object:C1471("productName"; "Soy Sauce"; "price"; 2.09; "quantityAvailable"; 5000; "expirationDate"; "2025-12-30"; "barcode"; "012345678901"); \
		New object:C1471("productName"; "Tuna"; "price"; 2.79; "quantityAvailable"; 5000; "expirationDate"; "2025-01-08"; "barcode"; "123456789012"); \
		New object:C1471("productName"; "Flour"; "price"; 1.39; "quantityAvailable"; 5000; "expirationDate"; "2025-12-27"; "barcode"; "234567890123"); \
		New object:C1471("productName"; "Butter"; "price"; 3.49; "quantityAvailable"; 5000; "expirationDate"; "2025-12-31"; "barcode"; "345678901234"); \
		New object:C1471("productName"; "Sugar"; "price"; 1.09; "quantityAvailable"; 5000; "expirationDate"; "2025-12-23"; "barcode"; "567890123456"); \
		New object:C1471("productName"; "Vinegar"; "price"; 0.79; "quantityAvailable"; 5000; "expirationDate"; "2025-12-26"; "barcode"; "678901234567"); \
		New object:C1471("productName"; "Honey"; "price"; 5.29; "quantityAvailable"; 5000; "expirationDate"; "2025-12-29"; "barcode"; "789012345678"))
	
	$i:=0
	For each ($item; $products)
		
		$product:=ds:C1482.Product.new()
		$product.name:=$item.productName
		$product.price:=$item.price
		$product.availableQuantity:=$item.quantityAvailable
		$product.expirationDate:=$item.expirationDate
		$product.barCode:=$item.barcode
		$product.category:=$categories.at(Random:C100%$categories.length)
		$info:=$product.save()
	End for each 
	
Function generateDish()
	var $dishes : Collection
	var $dish : cs:C1710.DishEntity
	var $sections : cs:C1710.MenuSectionSelection
	$sections:=ds:C1482.MenuSection.all()
	var $item : Object
	var $imageBlob : Blob
	var $info : Object
	var $images : Collection
	var $i : Integer
	var $macros : Object
	var $destPicture : Picture
	
	$dishes:=New collection:C1472()
	$dishes.push(New object:C1471("dishName"; "Chicken Alfredo"; "description"; "Creamy pasta with grilled chicken;Alfredo sauce;and Parmesan cheese"; "price"; 14.99; "availability"; True:C214); New object:C1471("dishName"; "Margherita Pizza"; "description"; "Classic pizza with tomato sauce;fresh mozzarella;basil;and olive oil"; "price"; 10.99; "availability"; True:C214); New object:C1471("dishName"; "Vegetable Stir-Fry"; "description"; "Colorful stir-fried vegetables with tofu;soy sauce;and ginger"; "price"; 12.49; "availability"; True:C214); New object:C1471("dishName"; "Grilled Salmon"; "description"; "Grilled salmon fillet served with lemon butter sauce and steamed vegetables"; "price"; 17.99; "availability"; True:C214); New object:C1471("dishName"; "Mushroom Risotto"; "description"; "Creamy Italian risotto with assorted mushrooms;Parmesan cheese;and truffle oil"; "price"; 15.49; "availability"; True:C214); New object:C1471("dishName"; "Beef Stir-Fry"; "description"; "Tender slices of beef stir-fried with broccoli;bell peppers;and oyster sauce"; "price"; 13.99; "availability"; True:C214); New object:C1471("dishName"; "Shrimp Scampi"; "description"; "Shrimp sautéed with garlic;white wine;lemon juice;and parsley;served over linguine"; "price"; 16.79; "availability"; True:C214); New object:C1471("dishName"; "Caprese Salad"; "description"; "Fresh mozzarella;tomatoes;and basil drizzled with balsamic glaze"; "price"; 9.99; "availability"; True:C214); New object:C1471("dishName"; "Lemon Herb Roasted Chicken"; "description"; "Roasted chicken seasoned with lemon;garlic;and fresh herbs;served with roasted vegetables"; "price"; 14.29; "availability"; True:C214); New object:C1471("dishName"; "Eggplant Parmesan"; "description"; "Breaded and baked eggplant slices layered with marinara sauce and mozzarella cheese"; "price"; 12.79; "availability"; True:C214); New object:C1471("dishName"; "Spaghetti Bolognese"; "description"; "Traditional Italian pasta with rich meat sauce;tomatoes;and Parmesan cheese"; "price"; 11.99; "availability"; True:C214); New object:C1471("dishName"; "Caesar Salad"; "description"; "Crisp romaine lettuce;croutons;Parmesan cheese;and Caesar dressing"; "price"; 8.49; "availability"; True:C214); New object:C1471("dishName"; "Sushi Platter"; "description"; "Assorted sushi rolls with fresh fish;rice;seaweed;and soy sauce"; "price"; 18.99; "availability"; True:C214); New object:C1471("dishName"; "Beef Tacos"; "description"; "Soft corn tortillas filled with seasoned beef;lettuce;cheese;and salsa"; "price"; 10.49; "availability"; True:C214); New object:C1471("dishName"; "Vegetarian Curry"; "description"; "Mixed vegetables cooked in spicy curry sauce;served with basmati rice"; "price"; 13.29; "availability"; True:C214); New object:C1471("dishName"; "Chocolate Lava Cake"; "description"; "Warm chocolate cake with a gooey;molten center;topped with vanilla ice cream"; "price"; 7.99; "availability"; True:C214); New object:C1471("dishName"; "Fettuccine Alfredo"; "description"; "Creamy Alfredo sauce tossed with fettuccine pasta;garnished with parsley"; "price"; 12.99; "availability"; True:C214); New object:C1471("dishName"; "Mango Sticky Rice"; "description"; "Sweet sticky rice topped with fresh mango slices and coconut milk"; "price"; 6.79; "availability"; True:C214); New object:C1471("dishName"; "BBQ Pulled Pork Sandwich"; "description"; "Slow-cooked pulled pork in BBQ sauce;served in a bun with coleslaw"; "price"; 11.49; "availability"; True:C214); New object:C1471("dishName"; "Greek Salad"; "description"; "Crisp lettuce;olives;tomatoes;cucumbers;feta cheese;and Greek dressing"; "price"; 9.79; "availability"; True:C214))
	$i:=0
	For each ($item; $dishes)
		$dish:=ds:C1482.Dish.new()
		$dish.name:=$item.dishName
		$dish.description:=$item.description
		$dish.price:=$item.price
		$dish.macros:=New object:C1471("Protein"; Random:C100%25; "Fat"; Random:C100%25; "Carbohydrates"; Random:C100%25)
		$dish.availability:=$item.availability
		$dish.section:=$sections.at(Random:C100%($sections.length))
		$info:=$dish.save()
		This:C1470.giveDish($dish)
	End for each 
	
Function generateTable()
	var $tables : Collection
	var $table : cs:C1710.TableEntity
	var $item : Object
	var $info : Object
	
	
	$tables:=New collection:C1472
	$tables.push(New object:C1471("numberTable"; 1; "capacity"; 4; "statut"; "Available"); New object:C1471("numberTable"; 2; "capacity"; 6; "statut"; "Occupied"); New object:C1471("numberTable"; 3; "capacity"; 2; "statut"; "Available"); New object:C1471("numberTable"; 4; "capacity"; 8; "statut"; "Reserved"); New object:C1471("numberTable"; 5; "capacity"; 4; "statut"; "Available"); New object:C1471("numberTable"; 6; "capacity"; 6; "statut"; "Occupied"); New object:C1471("numberTable"; 7; "capacity"; 2; "statut"; "Available"); New object:C1471("numberTable"; 8; "capacity"; 8; "statut"; "Reserved"); New object:C1471("numberTable"; 9; "capacity"; 4; "statut"; "Available"); New object:C1471("numberTable"; 10; "capacity"; 6; "statut"; "Occupied"))
	
	For each ($item; $tables)
		$table:=ds:C1482.Table.new()
		$table.capacity:=$item.capacity
		$table.status:=$item.statut
		$info:=$table.save()
	End for each 
	
Function generateMenu()
	var $menus : Collection
	var $menuSection : cs:C1710.MenuSectionEntity
	var $item : Object
	var $info : Object
	
	$menus:=New collection:C1472
	$menus.push(New object:C1471("name"; "Sides"; "description"; "Indulge in a variety of flavorful side dishes"); \
		New object:C1471("name"; "Drinks"; "description"; "Quench your thirst with our refreshing drink options"); \
		New object:C1471("name"; "Appetizers"; "description"; "Explore a diverse selection of appetizers"); \
		New object:C1471("name"; "Salads"; "description"; "Warm up with our hearty soups and enjoy refreshing salads made with crisp;fresh ingredients"); \
		New object:C1471("name"; "Entrees"; "description"; "Delight in our main course offerings with a variety of options"); \
		New object:C1471("name"; "Pasta"; "description"; "Savor the flavors of our delicious pasta dishes"); \
		New object:C1471("name"; "Burgers"; "description"; "Enjoy the taste of America with our iconic burgers"); \
		New object:C1471("name"; "Pizza"; "description"; "Indulge in our mouthwatering pizza options"); \
		New object:C1471("name"; "Desserts"; "description"; "Indulge your sweet tooth with our exquisite desserts;from cakes to pastries"))
	
	For each ($item; $menus)
		$menuSection:=ds:C1482.MenuSection.new()
		$menuSection.name:=$item.name
		$menuSection.description:=$item.description
		$info:=$menuSection.save()
	End for each 
	
	
Function generateFacture()
	var $factures : Collection
	var $facture : cs:C1710.FactureEntity
	var $item : Object
	var $info : Object
	
	$factures:=New collection:C1472
	$factures.push(New object:C1471("dateFacture"; "2023-11-01"; "totalPrice"; 150.75; "modePayment"; "Credit Card"; "statut"; "Paid"); \
		New object:C1471("dateFacture"; "2023-11-02"; "totalPrice"; 92.4; "modePayment"; "Cash"; "statut"; "Paid"); \
		New object:C1471("dateFacture"; "2023-11-03"; "totalPrice"; 210.2; "modePayment"; "Debit Card"; "statut"; "Ready"); \
		New object:C1471("dateFacture"; "2023-11-04"; "totalPrice"; 78.9; "modePayment"; "Credit Card"; "statut"; "Paid"); \
		New object:C1471("dateFacture"; "2023-11-05"; "totalPrice"; 135.6; "modePayment"; "Cash"; "statut"; "Paid"); \
		New object:C1471("dateFacture"; "2023-11-06"; "totalPrice"; 185.25; "modePayment"; "Debit Card"; "statut"; "Paid"); \
		New object:C1471("dateFacture"; "2023-11-07"; "totalPrice"; 96.7; "modePayment"; "Credit Card"; "statut"; "Ready"); \
		New object:C1471("dateFacture"; "2023-11-08"; "totalPrice"; 123.45; "modePayment"; "Cash"; "statut"; "Paid"); \
		New object:C1471("dateFacture"; "2023-11-09"; "totalPrice"; 178.9; "modePayment"; "Credit Card"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-10"; "totalPrice"; 215.3; "modePayment"; "Debit Card"; "statut"; "Ready"); New object:C1471("dateFacture"; "2023-11-11"; "totalPrice"; 75.2; "modePayment"; "Cash"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-12"; "totalPrice"; 132.8; "modePayment"; "Credit Card"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-13"; "totalPrice"; 165.9; "modePayment"; "Debit Card"; "statut"; "Ready"); New object:C1471("dateFacture"; "2023-11-14"; "totalPrice"; 89.6; "modePayment"; "Cash"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-15"; "totalPrice"; 205.4; "modePayment"; "Credit Card"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-16"; "totalPrice"; 98.75; "modePayment"; "Cash"; "statut"; "Ready"); New object:C1471("dateFacture"; "2023-11-17"; "totalPrice"; 120.3; "modePayment"; "Credit Card"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-18"; "totalPrice"; 179.2; "modePayment"; "Debit Card"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-19"; "totalPrice"; 135.9; "modePayment"; "Cash"; "statut"; "Ready"); New object:C1471("dateFacture"; "2023-11-20"; "totalPrice"; 210.6; "modePayment"; "Credit Card"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-21"; "totalPrice"; 88.4; "modePayment"; "Cash"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-22"; "totalPrice"; 165.7; "modePayment"; "Debit Card"; "statut"; "Ready"); New object:C1471("dateFacture"; "2023-11-23"; "totalPrice"; 123.8; "modePayment"; "Credit Card"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-24"; "totalPrice"; 145.2; "modePayment"; "Cash"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-25"; "totalPrice"; 198.5; "modePayment"; "Credit Card"; "statut"; "Ready"); New object:C1471("dateFacture"; "2023-11-26"; "totalPrice"; 76.9; "modePayment"; "Debit Card"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-27"; "totalPrice"; 110.7; "modePayment"; "Cash"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-28"; "totalPrice"; 189.4; "modePayment"; "Credit Card"; "statut"; "Ready"); New object:C1471("dateFacture"; "2023-11-29"; "totalPrice"; 96.6; "modePayment"; "Cash"; "statut"; "Paid"); New object:C1471("dateFacture"; "2023-11-30"; "totalPrice"; 155.8; "modePayment"; "Debit Card"; "statut"; "Paid"))
	
	For each ($item; $factures)
		$facture:=ds:C1482.Facture.new()
		$facture.dateFacture:=$item.dateFacture
		$facture.paymentMode:=$item.modePayment
		$facture.status:=$item.statut
		$info:=$facture.save()
	End for each 
	
Function generateOrder()
	var $orders : Collection
	var $order : cs:C1710.OrderEntity
	var $item : Object
	var $info : Object
	var $tables : cs:C1710.TableSelection
	var $table : cs:C1710.TableEntity
	var $waiters : cs:C1710.WaiterSelection
	$waiters:=ds:C1482.Waiter.all()
	
	var $randomPhone : Integer
	var $randomSuite : Integer
	var $randomStreetAdd : Integer
	
	$randomPhone:=(Random:C100%89999998)+99999999
	$randomSuite:=(Random:C100%100)+1
	$randomStreetAdd:=(Random:C100%1000)+100
	
	$orders:=New collection:C1472
	$orders.push(New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 120.75; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "John Smith"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 92.4; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Emily Johnson"; "orderType"; "Dine-In"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 210.2; "modePayment"; "Debit Card"; "statut"; "In Progress"; "ordererFullName"; "Michael Davis"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 78.9; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Sarah Wilson"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 135.6; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "David Brown"; "orderType"; "Dine-In"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 185.25; "modePayment"; "Debit Card"; "statut"; "In Progress"; "ordererFullName"; "Lisa Anderson"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 96.7; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Daniel Miller"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 123.45; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Jessica Lee"; "orderType"; "Dine-In"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 178.9; "modePayment"; "Credit Card"; "statut"; "In Progress"; "ordererFullName"; "Christopher Hall"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 215.3; "modePayment"; "Debit Card"; "statut"; "Ready"; "ordererFullName"; "Megan Wilson"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 75.2; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Ryan Taylor"; "orderType"; "Dine-In"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 132.8; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Emma Clark"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 165.9; "modePayment"; "Debit Card"; "statut"; "In Progress"; "ordererFullName"; "Andrew Hill"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 89.6; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Olivia Turner"; "orderType"; "Dine-In"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 205.4; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Liam Carter"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33(); "totalPrice"; 98.75; "modePayment"; "Cash"; "statut"; "In Progress"; "ordererFullName"; "Ava Mitchell"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33()+1; "totalPrice"; 120.3; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Noah Garcia"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33()+1; "totalPrice"; 179.2; "modePayment"; "Debit Card"; "statut"; "Delivered"; "ordererFullName"; "Sophia Diaz"; "orderType"; "Dine-In"); \
		New object:C1471("orderDate"; Current date:C33()+1; "totalPrice"; 135.9; "modePayment"; "Cash"; "statut"; "In Progress"; "ordererFullName"; "Ethan Nelson"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33()+1; "totalPrice"; 210.6; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Chloe Evans"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33()+1; "totalPrice"; 88.4; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Landon Cooper"; "orderType"; "Dine-In"); \
		New object:C1471("orderDate"; Current date:C33()+1; "totalPrice"; 165.7; "modePayment"; "Debit Card"; "statut"; "In Progress"; "ordererFullName"; "Lily Brooks"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33()+2; "totalPrice"; 123.8; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Lucas Ward"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33()+2; "totalPrice"; 145.2; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Zoe Murphy"; "orderType"; "Dine-In"); \
		New object:C1471("orderDate"; Current date:C33()+2; "totalPrice"; 198.5; "modePayment"; "Credit Card"; "statut"; "In Progress"; "ordererFullName"; "Mason Ramirez"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33()+2; "totalPrice"; 76.9; "modePayment"; "Debit Card"; "statut"; "Delivered"; "ordererFullName"; "Harper Bennett"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33()+2; "totalPrice"; 110.7; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Jackson Foster"; "orderType"; "Dine-In"); \
		New object:C1471("orderDate"; Current date:C33()+2; "totalPrice"; 189.4; "modePayment"; "Credit Card"; "statut"; "In Progress"; "ordererFullName"; "Aria Nelson"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33()+2; "totalPrice"; 96.6; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Elijah Carter"; "orderType"; "Delivery"); \
		New object:C1471("orderDate"; Current date:C33()+2; "totalPrice"; 155.8; "modePayment"; "Debit Card"; "statut"; "Delivered"; "ordererFullName"; "Scarlett Hayes"; "orderType"; "Dine-In"))
	$tables:=ds:C1482.Table.all()
	For each ($item; $orders)
		$order:=ds:C1482.Order.new()
		$order.orderDate:=$item.orderDate
		$order.status:=$item.statut
		$order.table:=$tables.at(Random:C100%($tables.length+1))
		$order.ordererFullName:=$item.ordererFullName
		$order.contactInfo:=New object:C1471("phone"; String:C10($randomPhone); "address"; String:C10($randomStreetAdd)+" Elm Street; Suite "+String:C10($randomSuite))
		$order.type:=$item.orderType
		$order.orderingHour:=Current time:C178()
		$order.waiter:=$waiters.at(Random:C100%($waiters.length))
		$info:=$order.save()
	End for each 
	
	
Function generateWaiter()
	var $users : cs:C1710.UserSelection
	var $user : cs:C1710.UserEntity
	var $waiter : cs:C1710.WaiterEntity
	$users:=ds:C1482.User.all()
	For each ($user; $users)
		If ($user.role="Waiter")
			If (ds:C1482.Waiter.query("user.mail = :1"; $user.mail).length=0)
				$waiter:=ds:C1482.Waiter.new()
				$waiter.user:=$user
				$waiter.save()
			End if 
		End if 
	End for each 
	If (ds:C1482.Waiter.all().length=0)
		For each ($user; $users)
			$waiter:=ds:C1482.Waiter.new()
			$waiter.user:=$user
			$waiter.save()
		End for each 
	End if 
	
	
Function generateOrdersDish()
	var $ordersDish : cs:C1710.OrderDishEntity
	var $orders : cs:C1710.OrderSelection
	var $dishes : cs:C1710.DishSelection
	var $dish : cs:C1710.DishEntity
	var $order : cs:C1710.OrderEntity
	var $info : Object
	
	$orders:=ds:C1482.Order.all()
	$dishes:=ds:C1482.Dish.all()
	
	For each ($dish; $dishes)
		For each ($order; $orders)
			If (Random:C100%3=0)
				$ordersDish:=ds:C1482.OrderDish.new()
				$ordersDish.order:=$order
				$ordersDish.dish:=$dish
				$ordersDish.quantity:=(Random:C100%5)+1
				$info:=$ordersDish.save()
			End if 
		End for each 
	End for each 
	
Function generateDishProduct()
	var $dishProduct : cs:C1710.DishProductEntity
	var $products : cs:C1710.ProductSelection
	var $dishes : cs:C1710.DishSelection
	var $product : cs:C1710.ProductEntity
	var $dish : cs:C1710.DishEntity
	var $info : Object
	
	$products:=ds:C1482.Product.all()
	$dishes:=ds:C1482.Dish.all()
	
	For each ($product; $products)
		For each ($dish; $dishes)
			If (Random:C100%3=0)
				$dishProduct:=ds:C1482.DishProduct.new()
				$dishProduct.product:=$product
				$dishProduct.dish:=$dish
				$dishProduct.quantity:=(Random:C100%200)
				$info:=$dishProduct.save()
			End if 
		End for each 
	End for each 
	
Function generateProductSupplier()
	var $productSupplier : cs:C1710.ProductSupplierEntity
	var $products : cs:C1710.ProductSelection
	var $suppliers : cs:C1710.DishSelection
	var $product : cs:C1710.ProductEntity
	var $supplier : cs:C1710.SupplierEntity
	var $info : Object
	
	$products:=ds:C1482.Product.all()
	$suppliers:=ds:C1482.Supplier.all()
	
	For each ($supplier; $suppliers)
		For each ($product; $products)
			If (Random:C100%3=0)
				$productSupplier:=ds:C1482.ProductSupplier.new()
				$productSupplier.product:=$product
				$productSupplier.supplier:=$supplier
				$info:=$productSupplier.save()
			End if 
		End for each 
	End for each 
	
Function giveDish($dish : cs:C1710.DishEntity)
	var $menu : cs:C1710.MenuSectionEntity
	For each ($menu; ds:C1482.MenuSection.all())
		If ($menu.dishes.length=0)
			$dish.section:=$menu
			$dish.save()
		End if 
	End for each 
	
Function generateDishesWithNoSection()
	var $dishes : Collection
	var $dish : cs:C1710.DishEntity
	var $item : Object
	var $info : Object
	var $i : Integer
	var $macros : Object
	$dishes:=New collection:C1472()
	$dishes.push(New object:C1471("dishName"; "Chicken Pasta original"; "description"; "Creamy pasta with grilled chicken;Alfredo sauce;and Parmesan cheese"; "price"; 14.99; "availability"; True:C214); \
		New object:C1471("dishName"; "American Burger original"; "description"; "Classic burger with tomato sauce;fresh mozzarella coming up with Fries;basil;and olive oil"; "price"; 15.99; "availability"; True:C214); \
		New object:C1471("dishName"; "Meaty Stir-Fry original"; "description"; "Colorful stir-fried vegetables with tofu;soy sauce;and ginger"; "price"; 12.49; "availability"; True:C214); \
		New object:C1471("dishName"; "Grilled Fish original"; "description"; "Grilled Fish fillet served with lemon butter sauce and steamed vegetables"; "price"; 17.99; "availability"; True:C214); \
		New object:C1471("dishName"; "Paella with octopus original"; "description"; "Creamy Italian risotto with assorted mushrooms;Parmesan cheese;and truffle oil"; "price"; 15.49; "availability"; True:C214))
	$i:=0
	For each ($item; $dishes)
		$dish:=ds:C1482.Dish.new()
		$dish.name:=$item.dishName
		$dish.description:=$item.description
		$dish.price:=$item.price
		$dish.macros:=New object:C1471("Protein"; Random:C100%25; "Fat"; Random:C100%25; "Carbohydrates"; Random:C100%25)
		$dish.availability:=$item.availability
		$info:=$dish.save()
		$i:=$i+1
	End for each 
	
	
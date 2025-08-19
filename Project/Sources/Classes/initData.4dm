Class constructor
	
	
	
Function dropData()
	var $trash : Object
	$trash:=ds.User.all().drop()
	$trash:=ds.Waiter.all().drop()
	$trash:=ds.Order.all().drop()
	$trash:=ds.Table.all().drop()
	$trash:=ds.MenuSection.all().drop()
	$trash:=ds.Dish.all().drop()
	$trash:=ds.Product.all().drop()
	$trash:=ds.Facture.all().drop()
	$trash:=ds.Supplier.all().drop()
	$trash:=ds.Category.all().drop()
	$trash:=ds.OrderDish.all().drop()
	$trash:=ds.DishProduct.all().drop()
	$trash:=ds.ProductSupplier.all().drop()
	
	
Function createData()
	This.generateUsers()
	This.generateWaiter()
	This.generateTable()
	This.generateFacture()
	This.generateCategory()
	This.generateProduct()
	This.generateSupplier()
	This.generateMenu()
	This.generateDish()
	This.generateOrder()
	This.generateOrdersDish()
	This.generateDishProduct()
	This.generateProductSupplier()
	This.generateDishesWithNoSection()
	
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
	var $newUser : cs.UserEntity
	
	For each ($user; $users)
		$newUser:=ds.User.new()
		$newUser.firstName:=$user.firstName
		$newUser.lastName:=$user.lastName
		$newUser.password:=Generate password hash($user.password)
		$newUser.mail:=$user.email
		$newUser.role:=$user.role
		$newUser.save()
	End for each 
	
	
Function generateCategory()
	var $categories : Collection
	var $item : Text
	var $category : cs.CategoryEntity
	var $info : Object
	
	$categories:=["Meat and Poultry and Eggs"; "Seafood"; "Dairy and Dairy Alternatives"; "Grains and Ceintegers"; "Fruits"; "Vegetables"; "Nuts and Seeds"; "Sweeteners"; "Oils and Fats"; "Herbs and Spices"; "Condiments and Sauces"]
	
	For each ($item; $categories)
		$category:=ds.Category.new()
		$category.name:=$item
		$category:=$category.save()
	End for each 
	
Function generateSupplier()
	var $suppliers : Collection
	var $supplier : cs.SupplierEntity
	var $item : Object
	var $info : Object
	
	$suppliers:=New collection()
	$suppliers.push(New object("Name"; "Ocean Fresh Seafood"; "contactInfo"; New object("Phone"; "888-222-3333"; "Email"; "info@oceanfreshseafood.com"); "address"; New object("street"; "234 Ocean Ave"; "city"; "Seafood City"; "state"; "State"; "zip"; "24680")); \
		New object("Name"; "Meat Master Inc."; "contactInfo"; New object("Phone"; "444-666-7777"; "Email"; "info@meatmaster.com"); "address"; New object("street"; "567 Butcher Block"; "city"; "Meatville"; "state"; "State"; "zip"; "97531")); \
		New object("Name"; "Gourmet Grocers Ltd."; "contactInfo"; New object("Phone"; "111-333-5555"; "Email"; "info@gourmetgrocers.com"); "address"; New object("street"; "789 Gourmet St"; "city"; "Delightville"; "state"; "State"; "zip"; "54321")); \
		New object("Name"; "Fresh Fruit Farms"; "contactInfo"; New object("Phone"; "777-999-1111"; "Email"; "info@freshfruitfarms.com"); "address"; New object("street"; "222 Fruit St"; "city"; "Orchardville"; "state"; "State"; "zip"; "78965")); \
		New object("Name"; "Green Leaf Vegetables"; "contactInfo"; New object("Phone"; "555-888-9999"; "Email"; "info@greenleafveggies.com"); "address"; New object("street"; "333 Veggie Blvd"; "city"; "Greensville"; "state"; "State"; "zip"; "45678")))
	For each ($item; $suppliers)
		$supplier:=ds.Supplier.new()
		$supplier.name:=$item.Name
		$supplier.contactInfo:=$item.contactInfo
		$supplier.address:=$item.address
		$supplier.description:=$item.Name+" is a major foodservice distributor with an annual revenue of $28.1 billion. Headquartered in "+$item.address.city+". The company serves over 300;000 customers and operates more than 70 distribution facilities."
		$info:=$supplier.save()
	End for each 
	
Function generateProduct()
	var $products : Collection
	var $product : cs.ProductEntity
	var $item : Object
	var $info : Object
	var $categories : cs.CategorySelection
	var $i : Integer
	
	$categories:=ds.Category.all()
	$products:=New collection
	$products.push(New object("productName"; "Chicken Breast"; "price"; 3.99; "quantityAvailable"; 5000; "expirationDate"; "2025-12-31"; "barcode"; "123456789012"); \
		New object("productName"; "Tomatoes"; "price"; 1.49; "quantityAvailable"; 5000; "expirationDate"; "2025-12-15"; "barcode"; "234567890123"); \
		New object("productName"; "Pasta"; "price"; 2.29; "quantityAvailable"; 5000; "expirationDate"; "2025-01-10"; "barcode"; "345678901234"); \
		New object("productName"; "Beef Steak"; "price"; 5.99; "quantityAvailable"; 5000; "expirationDate"; "2025-12-28"; "barcode"; "456789012345"); \
		New object("productName"; "Lettuce"; "price"; 1.19; "quantityAvailable"; 5000; "expirationDate"; "2025-12-20"; "barcode"; "567890123456"); \
		New object("productName"; "Shrimp"; "price"; 6.49; "quantityAvailable"; 5000; "expirationDate"; "2025-12-25"; "barcode"; "678901234567"); \
		New object("productName"; "Mushrooms"; "price"; 2.99; "quantityAvailable"; 5000; "expirationDate"; "2025-12-18"; "barcode"; "789012345678"); \
		New object("productName"; "Onions"; "price"; 0.99; "quantityAvailable"; 5000; "expirationDate"; "2025-12-22"; "barcode"; "890123456789"); \
		New object("productName"; "Salmon Fillet"; "price"; 7.99; "quantityAvailable"; 5000; "expirationDate"; "2025-12-30"; "barcode"; "901234567890"); \
		New object("productName"; "Bell Peppers"; "price"; 1.29; "quantityAvailable"; 5000; "expirationDate"; "2025-12-18"; "barcode"; "012345678901"); \
		New object("productName"; "Cheese"; "price"; 4.49; "quantityAvailable"; 5000; "expirationDate"; "2025-12-29"; "barcode"; "123456789012"); \
		New object("productName"; "Eggs"; "price"; 1.89; "quantityAvailable"; 5000; "expirationDate"; "2025-12-25"; "barcode"; "234567890123"); \
		New object("productName"; "Rice"; "price"; 1.99; "quantityAvailable"; 5000; "expirationDate"; "2025-01-05"; "barcode"; "345678901234"); \
		New object("productName"; "Carrots"; "price"; 0.79; "quantityAvailable"; 5000; "expirationDate"; "2025-12-21"; "barcode"; "456789012345"); \
		New object("productName"; "Garlic"; "price"; 0.69; "quantityAvailable"; 5000; "expirationDate"; "2025-12-24"; "barcode"; "567890123456"); \
		New object("productName"; "Olive Oil"; "price"; 3.29; "quantityAvailable"; 5000; "expirationDate"; "2025-01-15"; "barcode"; "678901234567"); \
		New object("productName"; "Lemon"; "price"; 0.89; "quantityAvailable"; 5000; "expirationDate"; "2025-12-22"; "barcode"; "789012345678"); \
		New object("productName"; "Salt"; "price"; 0.49; "quantityAvailable"; 5000; "expirationDate"; "2025-01-01"; "barcode"; "890123456789"); \
		New object("productName"; "Black Pepper"; "price"; 0.59; "quantityAvailable"; 5000; "expirationDate"; "2025-02-01"; "barcode"; "901234567890"); \
		New object("productName"; "Soy Sauce"; "price"; 2.09; "quantityAvailable"; 5000; "expirationDate"; "2025-12-30"; "barcode"; "012345678901"); \
		New object("productName"; "Tuna"; "price"; 2.79; "quantityAvailable"; 5000; "expirationDate"; "2025-01-08"; "barcode"; "123456789012"); \
		New object("productName"; "Flour"; "price"; 1.39; "quantityAvailable"; 5000; "expirationDate"; "2025-12-27"; "barcode"; "234567890123"); \
		New object("productName"; "Butter"; "price"; 3.49; "quantityAvailable"; 5000; "expirationDate"; "2025-12-31"; "barcode"; "345678901234"); \
		New object("productName"; "Sugar"; "price"; 1.09; "quantityAvailable"; 5000; "expirationDate"; "2025-12-23"; "barcode"; "567890123456"); \
		New object("productName"; "Vinegar"; "price"; 0.79; "quantityAvailable"; 5000; "expirationDate"; "2025-12-26"; "barcode"; "678901234567"); \
		New object("productName"; "Honey"; "price"; 5.29; "quantityAvailable"; 5000; "expirationDate"; "2025-12-29"; "barcode"; "789012345678"))
	
	$i:=0
	For each ($item; $products)
		
		$product:=ds.Product.new()
		$product.name:=$item.productName
		$product.price:=$item.price
		$product.availableQuantity:=$item.quantityAvailable
		$product.expirationDate:=$item.expirationDate
		$product.barCode:=$item.barcode
		$product.category:=$categories.at(Random%$categories.length)
		$info:=$product.save()
	End for each 
	
Function generateDish()
	var $dishes : Collection
	var $dish : cs.DishEntity
	var $sections : cs.MenuSectionSelection
	$sections:=ds.MenuSection.all()
	var $item : Object
	var $imageBlob : Blob
	var $info : Object
	var $images : Collection
	var $i : Integer
	var $macros : Object
	var $destPicture : Picture
	
	$dishes:=New collection()
	$dishes.push(New object("dishName"; "Chicken Alfredo"; "description"; "Creamy pasta with grilled chicken;Alfredo sauce;and Parmesan cheese"; "price"; 14.99; "availability"; True); New object("dishName"; "Margherita Pizza"; "description"; "Classic pizza with tomato sauce;fresh mozzarella;basil;and olive oil"; "price"; 10.99; "availability"; True); New object("dishName"; "Vegetable Stir-Fry"; "description"; "Colorful stir-fried vegetables with tofu;soy sauce;and ginger"; "price"; 12.49; "availability"; True); New object("dishName"; "Grilled Salmon"; "description"; "Grilled salmon fillet served with lemon butter sauce and steamed vegetables"; "price"; 17.99; "availability"; True); New object("dishName"; "Mushroom Risotto"; "description"; "Creamy Italian risotto with assorted mushrooms;Parmesan cheese;and truffle oil"; "price"; 15.49; "availability"; True); New object("dishName"; "Beef Stir-Fry"; "description"; "Tender slices of beef stir-fried with broccoli;bell peppers;and oyster sauce"; "price"; 13.99; "availability"; True); New object("dishName"; "Shrimp Scampi"; "description"; "Shrimp sautéed with garlic;white wine;lemon juice;and parsley;served over linguine"; "price"; 16.79; "availability"; True); New object("dishName"; "Caprese Salad"; "description"; "Fresh mozzarella;tomatoes;and basil drizzled with balsamic glaze"; "price"; 9.99; "availability"; True); New object("dishName"; "Lemon Herb Roasted Chicken"; "description"; "Roasted chicken seasoned with lemon;garlic;and fresh herbs;served with roasted vegetables"; "price"; 14.29; "availability"; True); New object("dishName"; "Eggplant Parmesan"; "description"; "Breaded and baked eggplant slices layered with marinara sauce and mozzarella cheese"; "price"; 12.79; "availability"; True); New object("dishName"; "Spaghetti Bolognese"; "description"; "Traditional Italian pasta with rich meat sauce;tomatoes;and Parmesan cheese"; "price"; 11.99; "availability"; True); New object("dishName"; "Caesar Salad"; "description"; "Crisp romaine lettuce;croutons;Parmesan cheese;and Caesar dressing"; "price"; 8.49; "availability"; True); New object("dishName"; "Sushi Platter"; "description"; "Assorted sushi rolls with fresh fish;rice;seaweed;and soy sauce"; "price"; 18.99; "availability"; True); New object("dishName"; "Beef Tacos"; "description"; "Soft corn tortillas filled with seasoned beef;lettuce;cheese;and salsa"; "price"; 10.49; "availability"; True); New object("dishName"; "Vegetarian Curry"; "description"; "Mixed vegetables cooked in spicy curry sauce;served with basmati rice"; "price"; 13.29; "availability"; True); New object("dishName"; "Chocolate Lava Cake"; "description"; "Warm chocolate cake with a gooey;molten center;topped with vanilla ice cream"; "price"; 7.99; "availability"; True); New object("dishName"; "Fettuccine Alfredo"; "description"; "Creamy Alfredo sauce tossed with fettuccine pasta;garnished with parsley"; "price"; 12.99; "availability"; True); New object("dishName"; "Mango Sticky Rice"; "description"; "Sweet sticky rice topped with fresh mango slices and coconut milk"; "price"; 6.79; "availability"; True); New object("dishName"; "BBQ Pulled Pork Sandwich"; "description"; "Slow-cooked pulled pork in BBQ sauce;served in a bun with coleslaw"; "price"; 11.49; "availability"; True); New object("dishName"; "Greek Salad"; "description"; "Crisp lettuce;olives;tomatoes;cucumbers;feta cheese;and Greek dressing"; "price"; 9.79; "availability"; True))
	$i:=0
	For each ($item; $dishes)
		$dish:=ds.Dish.new()
		$dish.name:=$item.dishName
		$dish.description:=$item.description
		$dish.price:=$item.price
		$dish.macros:=New object("Protein"; Random%25; "Fat"; Random%25; "Carbohydrates"; Random%25)
		$dish.availability:=$item.availability
		$dish.section:=$sections.at(Random%($sections.length))
		$info:=$dish.save()
		This.giveDish($dish)
	End for each 
	
Function generateTable()
	var $tables : Collection
	var $table : cs.TableEntity
	var $item : Object
	var $info : Object
	
	
	$tables:=New collection
	$tables.push(New object("numberTable"; 1; "capacity"; 4; "statut"; "Available"); New object("numberTable"; 2; "capacity"; 6; "statut"; "Occupied"); New object("numberTable"; 3; "capacity"; 2; "statut"; "Available"); New object("numberTable"; 4; "capacity"; 8; "statut"; "Reserved"); New object("numberTable"; 5; "capacity"; 4; "statut"; "Available"); New object("numberTable"; 6; "capacity"; 6; "statut"; "Occupied"); New object("numberTable"; 7; "capacity"; 2; "statut"; "Available"); New object("numberTable"; 8; "capacity"; 8; "statut"; "Reserved"); New object("numberTable"; 9; "capacity"; 4; "statut"; "Available"); New object("numberTable"; 10; "capacity"; 6; "statut"; "Occupied"))
	
	For each ($item; $tables)
		$table:=ds.Table.new()
		$table.capacity:=$item.capacity
		$table.status:=$item.statut
		$table.numberTable = item.numberTable
		$info:=$table.save()
	End for each 
	
Function generateMenu()
	var $menus : Collection
	var $menuSection : cs.MenuSectionEntity
	var $item : Object
	var $info : Object
	
	$menus:=New collection
	$menus.push(New object("name"; "Sides"; "description"; "Indulge in a variety of flavorful side dishes"); \
		New object("name"; "Drinks"; "description"; "Quench your thirst with our refreshing drink options"); \
		New object("name"; "Appetizers"; "description"; "Explore a diverse selection of appetizers"); \
		New object("name"; "Salads"; "description"; "Warm up with our hearty soups and enjoy refreshing salads made with crisp;fresh ingredients"); \
		New object("name"; "Entrees"; "description"; "Delight in our main course offerings with a variety of options"); \
		New object("name"; "Pasta"; "description"; "Savor the flavors of our delicious pasta dishes"); \
		New object("name"; "Burgers"; "description"; "Enjoy the taste of America with our iconic burgers"); \
		New object("name"; "Pizza"; "description"; "Indulge in our mouthwatering pizza options"); \
		New object("name"; "Desserts"; "description"; "Indulge your sweet tooth with our exquisite desserts;from cakes to pastries"))
	
	For each ($item; $menus)
		$menuSection:=ds.MenuSection.new()
		$menuSection.name:=$item.name
		$menuSection.description:=$item.description
		$info:=$menuSection.save()
	End for each 
	
	
Function generateFacture()
	var $factures : Collection
	var $facture : cs.FactureEntity
	var $item : Object
	var $info : Object
	
	$factures:=New collection
	$factures.push(New object("dateFacture"; "2023-11-01"; "totalPrice"; 150.75; "modePayment"; "Credit Card"; "statut"; "Paid"); \
		New object("dateFacture"; "2023-11-02"; "totalPrice"; 92.4; "modePayment"; "Cash"; "statut"; "Paid"); \
		New object("dateFacture"; "2023-11-03"; "totalPrice"; 210.2; "modePayment"; "Debit Card"; "statut"; "Ready"); \
		New object("dateFacture"; "2023-11-04"; "totalPrice"; 78.9; "modePayment"; "Credit Card"; "statut"; "Paid"); \
		New object("dateFacture"; "2023-11-05"; "totalPrice"; 135.6; "modePayment"; "Cash"; "statut"; "Paid"); \
		New object("dateFacture"; "2023-11-06"; "totalPrice"; 185.25; "modePayment"; "Debit Card"; "statut"; "Paid"); \
		New object("dateFacture"; "2023-11-07"; "totalPrice"; 96.7; "modePayment"; "Credit Card"; "statut"; "Ready"); \
		New object("dateFacture"; "2023-11-08"; "totalPrice"; 123.45; "modePayment"; "Cash"; "statut"; "Paid"); \
		New object("dateFacture"; "2023-11-09"; "totalPrice"; 178.9; "modePayment"; "Credit Card"; "statut"; "Paid"); New object("dateFacture"; "2023-11-10"; "totalPrice"; 215.3; "modePayment"; "Debit Card"; "statut"; "Ready"); New object("dateFacture"; "2023-11-11"; "totalPrice"; 75.2; "modePayment"; "Cash"; "statut"; "Paid"); New object("dateFacture"; "2023-11-12"; "totalPrice"; 132.8; "modePayment"; "Credit Card"; "statut"; "Paid"); New object("dateFacture"; "2023-11-13"; "totalPrice"; 165.9; "modePayment"; "Debit Card"; "statut"; "Ready"); New object("dateFacture"; "2023-11-14"; "totalPrice"; 89.6; "modePayment"; "Cash"; "statut"; "Paid"); New object("dateFacture"; "2023-11-15"; "totalPrice"; 205.4; "modePayment"; "Credit Card"; "statut"; "Paid"); New object("dateFacture"; "2023-11-16"; "totalPrice"; 98.75; "modePayment"; "Cash"; "statut"; "Ready"); New object("dateFacture"; "2023-11-17"; "totalPrice"; 120.3; "modePayment"; "Credit Card"; "statut"; "Paid"); New object("dateFacture"; "2023-11-18"; "totalPrice"; 179.2; "modePayment"; "Debit Card"; "statut"; "Paid"); New object("dateFacture"; "2023-11-19"; "totalPrice"; 135.9; "modePayment"; "Cash"; "statut"; "Ready"); New object("dateFacture"; "2023-11-20"; "totalPrice"; 210.6; "modePayment"; "Credit Card"; "statut"; "Paid"); New object("dateFacture"; "2023-11-21"; "totalPrice"; 88.4; "modePayment"; "Cash"; "statut"; "Paid"); New object("dateFacture"; "2023-11-22"; "totalPrice"; 165.7; "modePayment"; "Debit Card"; "statut"; "Ready"); New object("dateFacture"; "2023-11-23"; "totalPrice"; 123.8; "modePayment"; "Credit Card"; "statut"; "Paid"); New object("dateFacture"; "2023-11-24"; "totalPrice"; 145.2; "modePayment"; "Cash"; "statut"; "Paid"); New object("dateFacture"; "2023-11-25"; "totalPrice"; 198.5; "modePayment"; "Credit Card"; "statut"; "Ready"); New object("dateFacture"; "2023-11-26"; "totalPrice"; 76.9; "modePayment"; "Debit Card"; "statut"; "Paid"); New object("dateFacture"; "2023-11-27"; "totalPrice"; 110.7; "modePayment"; "Cash"; "statut"; "Paid"); New object("dateFacture"; "2023-11-28"; "totalPrice"; 189.4; "modePayment"; "Credit Card"; "statut"; "Ready"); New object("dateFacture"; "2023-11-29"; "totalPrice"; 96.6; "modePayment"; "Cash"; "statut"; "Paid"); New object("dateFacture"; "2023-11-30"; "totalPrice"; 155.8; "modePayment"; "Debit Card"; "statut"; "Paid"))
	
	For each ($item; $factures)
		$facture:=ds.Facture.new()
		$facture.dateFacture:=$item.dateFacture
		$facture.paymentMode:=$item.modePayment
		$facture.status:=$item.statut
		$info:=$facture.save()
	End for each 
	
Function generateOrder()
	var $orders : Collection
	var $order : cs.OrderEntity
	var $item : Object
	var $info : Object
	var $tables : cs.TableSelection
	var $table : cs.TableEntity
	var $waiters : cs.WaiterSelection
	$waiters:=ds.Waiter.all()
	
	var $randomPhone : Integer
	var $randomSuite : Integer
	var $randomStreetAdd : Integer
	
	$randomPhone:=(Random%89999998)+99999999
	$randomSuite:=(Random%100)+1
	$randomStreetAdd:=(Random%1000)+100
	
	$orders:=New collection
	$orders.push(New object("orderDate"; Current date(); "totalPrice"; 120.75; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "John Smith"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date(); "totalPrice"; 92.4; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Emily Johnson"; "orderType"; "Dine-In"); \
		New object("orderDate"; Current date(); "totalPrice"; 210.2; "modePayment"; "Debit Card"; "statut"; "In Progress"; "ordererFullName"; "Michael Davis"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date(); "totalPrice"; 78.9; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Sarah Wilson"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date(); "totalPrice"; 135.6; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "David Brown"; "orderType"; "Dine-In"); \
		New object("orderDate"; Current date(); "totalPrice"; 185.25; "modePayment"; "Debit Card"; "statut"; "In Progress"; "ordererFullName"; "Lisa Anderson"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date(); "totalPrice"; 96.7; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Daniel Miller"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date(); "totalPrice"; 123.45; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Jessica Lee"; "orderType"; "Dine-In"); \
		New object("orderDate"; Current date(); "totalPrice"; 178.9; "modePayment"; "Credit Card"; "statut"; "In Progress"; "ordererFullName"; "Christopher Hall"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date(); "totalPrice"; 215.3; "modePayment"; "Debit Card"; "statut"; "Ready"; "ordererFullName"; "Megan Wilson"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date(); "totalPrice"; 75.2; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Ryan Taylor"; "orderType"; "Dine-In"); \
		New object("orderDate"; Current date(); "totalPrice"; 132.8; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Emma Clark"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date(); "totalPrice"; 165.9; "modePayment"; "Debit Card"; "statut"; "In Progress"; "ordererFullName"; "Andrew Hill"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date(); "totalPrice"; 89.6; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Olivia Turner"; "orderType"; "Dine-In"); \
		New object("orderDate"; Current date(); "totalPrice"; 205.4; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Liam Carter"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date(); "totalPrice"; 98.75; "modePayment"; "Cash"; "statut"; "In Progress"; "ordererFullName"; "Ava Mitchell"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date()+1; "totalPrice"; 120.3; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Noah Garcia"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date()+1; "totalPrice"; 179.2; "modePayment"; "Debit Card"; "statut"; "Delivered"; "ordererFullName"; "Sophia Diaz"; "orderType"; "Dine-In"); \
		New object("orderDate"; Current date()+1; "totalPrice"; 135.9; "modePayment"; "Cash"; "statut"; "In Progress"; "ordererFullName"; "Ethan Nelson"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date()+1; "totalPrice"; 210.6; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Chloe Evans"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date()+1; "totalPrice"; 88.4; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Landon Cooper"; "orderType"; "Dine-In"); \
		New object("orderDate"; Current date()+1; "totalPrice"; 165.7; "modePayment"; "Debit Card"; "statut"; "In Progress"; "ordererFullName"; "Lily Brooks"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date()+2; "totalPrice"; 123.8; "modePayment"; "Credit Card"; "statut"; "Delivered"; "ordererFullName"; "Lucas Ward"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date()+2; "totalPrice"; 145.2; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Zoe Murphy"; "orderType"; "Dine-In"); \
		New object("orderDate"; Current date()+2; "totalPrice"; 198.5; "modePayment"; "Credit Card"; "statut"; "In Progress"; "ordererFullName"; "Mason Ramirez"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date()+2; "totalPrice"; 76.9; "modePayment"; "Debit Card"; "statut"; "Delivered"; "ordererFullName"; "Harper Bennett"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date()+2; "totalPrice"; 110.7; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Jackson Foster"; "orderType"; "Dine-In"); \
		New object("orderDate"; Current date()+2; "totalPrice"; 189.4; "modePayment"; "Credit Card"; "statut"; "In Progress"; "ordererFullName"; "Aria Nelson"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date()+2; "totalPrice"; 96.6; "modePayment"; "Cash"; "statut"; "Delivered"; "ordererFullName"; "Elijah Carter"; "orderType"; "Delivery"); \
		New object("orderDate"; Current date()+2; "totalPrice"; 155.8; "modePayment"; "Debit Card"; "statut"; "Delivered"; "ordererFullName"; "Scarlett Hayes"; "orderType"; "Dine-In"))
	$tables:=ds.Table.all()
	For each ($item; $orders)
		$order:=ds.Order.new()
		$order.orderDate:=$item.orderDate
		$order.status:=$item.statut
		$order.table:=$tables.at(Random%($tables.length+1))
		$order.ordererFullName:=$item.ordererFullName
		$order.contactInfo:=New object("phone"; String($randomPhone); "address"; String($randomStreetAdd)+" Elm Street; Suite "+String($randomSuite))
		$order.type:=$item.orderType
		$order.orderingHour:=Current time()
		$order.waiter:=$waiters.at(Random%($waiters.length))
		$info:=$order.save()
	End for each 
	
	
Function generateWaiter()
	var $users : cs.UserSelection
	var $user : cs.UserEntity
	var $waiter : cs.WaiterEntity
	$users:=ds.User.all()
	For each ($user; $users)
		If ($user.role="Waiter")
			If (ds.Waiter.query("user.mail = :1"; $user.mail).length=0)
				$waiter:=ds.Waiter.new()
				$waiter.user:=$user
				$waiter.save()
			End if 
		End if 
	End for each 
	If (ds.Waiter.all().length=0)
		For each ($user; $users)
			$waiter:=ds.Waiter.new()
			$waiter.user:=$user
			$waiter.save()
		End for each 
	End if 
	
	
Function generateOrdersDish()
	var $ordersDish : cs.OrderDishEntity
	var $orders : cs.OrderSelection
	var $dishes : cs.DishSelection
	var $dish : cs.DishEntity
	var $order : cs.OrderEntity
	var $info : Object
	
	$orders:=ds.Order.all()
	$dishes:=ds.Dish.all()
	
	For each ($dish; $dishes)
		For each ($order; $orders)
			If (Random%3=0)
				$ordersDish:=ds.OrderDish.new()
				$ordersDish.order:=$order
				$ordersDish.dish:=$dish
				$ordersDish.quantity:=(Random%5)+1
				$info:=$ordersDish.save()
			End if 
		End for each 
	End for each 
	
Function generateDishProduct()
	var $dishProduct : cs.DishProductEntity
	var $products : cs.ProductSelection
	var $dishes : cs.DishSelection
	var $product : cs.ProductEntity
	var $dish : cs.DishEntity
	var $info : Object
	
	$products:=ds.Product.all()
	$dishes:=ds.Dish.all()
	
	For each ($product; $products)
		For each ($dish; $dishes)
			If (Random%3=0)
				$dishProduct:=ds.DishProduct.new()
				$dishProduct.product:=$product
				$dishProduct.dish:=$dish
				$dishProduct.quantity:=(Random%200)
				$info:=$dishProduct.save()
			End if 
		End for each 
	End for each 
	
Function generateProductSupplier()
	var $productSupplier : cs.ProductSupplierEntity
	var $products : cs.ProductSelection
	var $suppliers : cs.DishSelection
	var $product : cs.ProductEntity
	var $supplier : cs.SupplierEntity
	var $info : Object
	
	$products:=ds.Product.all()
	$suppliers:=ds.Supplier.all()
	
	For each ($supplier; $suppliers)
		For each ($product; $products)
			If (Random%3=0)
				$productSupplier:=ds.ProductSupplier.new()
				$productSupplier.product:=$product
				$productSupplier.supplier:=$supplier
				$info:=$productSupplier.save()
			End if 
		End for each 
	End for each 
	
Function giveDish($dish : cs.DishEntity)
	var $menu : cs.MenuSectionEntity
	For each ($menu; ds.MenuSection.all())
		If ($menu.dishes.length=0)
			$dish.section:=$menu
			$dish.save()
		End if 
	End for each 
	
Function generateDishesWithNoSection()
	var $dishes : Collection
	var $dish : cs.DishEntity
	var $item : Object
	var $info : Object
	var $i : Integer
	var $macros : Object
	$dishes:=New collection()
	$dishes.push(New object("dishName"; "Chicken Pasta original"; "description"; "Creamy pasta with grilled chicken;Alfredo sauce;and Parmesan cheese"; "price"; 14.99; "availability"; True); \
		New object("dishName"; "American Burger original"; "description"; "Classic burger with tomato sauce;fresh mozzarella coming up with Fries;basil;and olive oil"; "price"; 15.99; "availability"; True); \
		New object("dishName"; "Meaty Stir-Fry original"; "description"; "Colorful stir-fried vegetables with tofu;soy sauce;and ginger"; "price"; 12.49; "availability"; True); \
		New object("dishName"; "Grilled Fish original"; "description"; "Grilled Fish fillet served with lemon butter sauce and steamed vegetables"; "price"; 17.99; "availability"; True); \
		New object("dishName"; "Paella with octopus original"; "description"; "Creamy Italian risotto with assorted mushrooms;Parmesan cheese;and truffle oil"; "price"; 15.49; "availability"; True))
	$i:=0
	For each ($item; $dishes)
		$dish:=ds.Dish.new()
		$dish.name:=$item.dishName
		$dish.description:=$item.description
		$dish.price:=$item.price
		$dish.macros:=New object("Protein"; Random%25; "Fat"; Random%25; "Carbohydrates"; Random%25)
		$dish.availability:=$item.availability
		$info:=$dish.save()
		$i:=$i+1
	End for each 
	
	
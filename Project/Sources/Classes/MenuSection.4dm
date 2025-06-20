Class extends DataClass

exposed function $search($search : text) : cs.MenuSectionSelection
	if ($search = null)
		return this.all()
	else 
		return this.query("name = :1"; "@"+$search+"@")
	end if 
	
	

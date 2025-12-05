Class extends Entity

	exposed function get fullName()->$fullName : text
	$fullName := ((this.firstName=null) && (this.lastName=null)) ? "" :(String(this.firstName)+" "+String(this.lastName))
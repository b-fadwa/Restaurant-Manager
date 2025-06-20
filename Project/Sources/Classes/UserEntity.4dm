Class extends Entity

// local function $aws()->$aws : object
// 	var $userCS: cs.Qodly.Users
// 	$userCS := cs.Qodly.Users.me
// 	if (session.storage.users = null)
// 		use (session.storage)
// 			session.storage.currentUser := new Shared Object("UUID"; this.UUID)
// 			session.storage.users := $userCS.allUsers().copy(16)
// 		end use 
// 	end if 
// 	if (session.storage.users # null)
// 		$aws := session.storage.users.query("username = :1"; this.awsID).at(0)
// 	end if 

// exposed function get role()->$role : text
// 	var $aws: object
// 	$role := ""
// 	$aws := this.aws()
// 	if ($aws # null)
// 		$role := $aws.role
// 	end if 
	
// exposed function get firstName()->$first : text
// 	var $aws: object
// 	$first := ""
// 	$aws := this.aws()
// 	if ($aws # null)
// 		$first := $aws.firstname
// 	end if 
	
// exposed function get lastName()->$lastname : text
// 	var $aws: object
// 	$lastname := ""
// 	$aws := this.aws()
// 	if ($aws # null)
// 		$lastname := $aws.lastname
// 	end if 
	
// exposed function get mail()->$mail : text
// 	var $aws: object
// 	$mail := ""
// 	$aws := this.aws()
// 	if ($aws # null)
// 		$mail := $aws.email
// 	end if 

	exposed function get fullName()->$fullName : text
	$fullName := ((this.firstName=null) && (this.lastName=null)) ? "" :(String(this.firstName)+" "+String(this.lastName))
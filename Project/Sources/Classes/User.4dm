Class extends DataClass

//getting the current connected user
exposed Function getCurrentUser() : cs:C1710.UserEntity
	return This:C1470.get(Session:C1714.storage.payLoad.UUID)
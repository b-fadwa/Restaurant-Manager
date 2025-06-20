Class extends DataClass

exposed Function getCurrentUser() : cs.UserEntity
	return This.get(Session.storage.payLoad.UUID)
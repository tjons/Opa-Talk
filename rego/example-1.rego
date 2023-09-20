package example

# assume the user list is invalid to start
default userListValid := false

# Our user list is valid if there is at least one admin user
userListValid {
	count(adminUsers) > 0
}

# build a set of admin users by filtering the user list
adminUsers[user.id] {
	# magic input variable
	user := input.users[_]
	user.role == "admin"
}

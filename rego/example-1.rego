package example

# assume the user list is invalid to start
default userListValid := false

# Our user list is valid if there is at least one admin user
userListValid := true {
    count(adminUsers) > 0
}

# build a set of admin users by filtering the user list
adminUsers[user.id] {
    user := input.users[_]
    user.role == "admin"
}
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

# build an object with the validation result and a message
validateUserList["userListValid"] = userListValid
validateUserList["reason"] = body

body := "The user list is invalid. Please ensure there is at least one admin user."  { not userListValid }
else := "The user list is valid."
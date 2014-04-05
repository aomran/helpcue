# Helpcue App

## Getting Started

The development environment requires the Ruby 2.1.1 and Postgresql. To get this setup please follow the instructions in the [Wiki](https://github.com/aomra015/curri/wiki) but make sure you upgrade everything.

1. `$ git clone git@github.com:aomra015/helpcue.git`
1. `$ cd helpcue`
1. `$ bundle install`
1. `$ rake db:create` ONLY THE FIRST TIME
1. `rake db:migrate`

### Start development environment (at localhost:3000)
- `$ rails s`

### Run tests
- `$ rake test` to run all Ruby tests.



# Devise controller helpers

* `before_action :authenticate_user!` in controllers to say that user should be logged in.
* `user_signed_in?` to check if user is signed in
* `current_user` to get get logged in user

# Devise path helpers

* `new_user_registration_path` -> sign up
* `edit_user_registration_path` -> edit user profile
* `new_user_session_path` -> sign in
* `destroy_user_session_path` -> sign out
* `new_user_password_path` -> reset password page
* `edit_user_password_path` -> change password page (after reset email)

# Devise controller test helpers

* `sign_in(@user)`
* `sign_out(@user)`
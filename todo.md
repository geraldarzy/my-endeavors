1. move methods from Helpers to application controller
2. fix rightuser? method, it should check to see if the current_user matches the given records user
3. use .update and mass assignment where applicable
4. utlize AR associations as much as possible
5. implement redirect_if_not_logged_in and redirect_if_not_authorized methods
6. stretch goal - implement AR validations and validations error messages
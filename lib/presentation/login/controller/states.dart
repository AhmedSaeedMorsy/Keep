abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class ChangeVisibilityPasswordState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSucecessState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String message;
  LoginErrorState(this.message);
}

class UserLoadingState extends LoginStates {}

class UserSucecessState extends LoginStates {}

class UserErrorState extends LoginStates {
  final String message;
  UserErrorState(this.message);
}

class UserLogOutLoadingState extends LoginStates {}

class UserLogOutSuccessState extends LoginStates {}

class UserLogOutErrorState extends LoginStates {
  final String error;
  UserLogOutErrorState(this.error);
}

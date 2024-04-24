import 'package:my_gallery/features/Authentication/data/models/login_model.dart';

abstract class AuthState{}

class AuthInitial extends AuthState{}

class LoginSuccess extends AuthState{
  final LoginModel loginModel;

  LoginSuccess(this.loginModel);
}

class LoginLoading extends AuthState{}

class LoginFailure extends AuthState{
  String errorMessage;
  LoginFailure({required this.errorMessage});
}
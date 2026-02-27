part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class LoginLoadingState extends AuthState {}
final class LoginSuccessState extends AuthState {}
final class LoginErrorState extends AuthState {
  String error;
  LoginErrorState(this.error);
}


final class RegisterLoadingState extends AuthState {}
final class RegisterSuccessState extends AuthState {}
final class RegisterErrorState extends AuthState {
  String error;
  RegisterErrorState(this.error);
}

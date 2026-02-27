import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/use_cases/register_use_case.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._registerUseCase , this._loginUseCase) : super(AuthInitial());

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> login() async {
    try {
      emit(LoginLoadingState());

      var result = await _loginUseCase.call(
          email: emailController.text, password: passwordController.text);
      emit(LoginSuccessState());
    } catch (e, s) {
      print(e.toString());
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> register() async {
    try {
      emit(RegisterLoadingState());
      var result = await _registerUseCase.call(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          phone: phoneController.text);
      emit(RegisterSuccessState());
    } catch (e, s) {
      print(e.toString());
      emit(RegisterErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}

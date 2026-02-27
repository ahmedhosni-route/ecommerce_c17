import 'package:ecommerce_app/features/auth/domain/enttity/user_entity.dart';

abstract class AuthRepo {
  Future<UserEntity> login({required String email, required String password});
  Future<UserEntity> register(
      {required String name,
      required String email,
      required String password,
      required String phone});
}

import 'package:ecommerce_app/features/auth/domain/enttity/user_entity.dart';
import 'package:injectable/injectable.dart';

import '../../data/repo/repo_imp.dart';
import '../repo/repo.dart';


@injectable
class RegisterUseCase {
  AuthRepo repo;
  RegisterUseCase(this.repo);

  Future<UserEntity> call(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    return repo.register(
        name: name, email: email, password: password, phone: phone);
  }
}

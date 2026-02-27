import 'package:ecommerce_app/features/auth/data/repo/repo_imp.dart';
import 'package:ecommerce_app/features/auth/domain/repo/repo.dart';
import 'package:injectable/injectable.dart';

import '../enttity/user_entity.dart';


@injectable
class LoginUseCase {
  AuthRepo repo ;

  LoginUseCase(this.repo);

  Future<UserEntity> call({required String email, required String password}) {
    return repo.login(email: email, password: password);
  }
}

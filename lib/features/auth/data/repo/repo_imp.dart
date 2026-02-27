import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/auth/data/data_source/data_source.dart';
import 'package:ecommerce_app/features/auth/data/data_source/data_source_imp.dart';
import 'package:ecommerce_app/features/auth/data/models/auth_response.dart';
import 'package:ecommerce_app/features/auth/domain/enttity/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repo/repo.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: AuthRepo )
class AuthRepoImp implements AuthRepo {
  AuthDataSource dataSource ;
  AuthRepoImp(this.dataSource);


  @override
  Future<UserEntity> login(
      {required String email, required String password}) async {
    try {
      var response = await dataSource.login(email: email, password: password);

      if (response.statusCode == 200) {
        AuthResponse authResponse = AuthResponse.fromJson(response.data);
        return authResponse.toEntity();
      } else {
        throw "Invalid email or password";
      }
    } on DioException catch (e) {
      throw e.response?.data["message"];
    } catch (e, s) {
      print(e);
      print(s);
      throw e.toString();
    }
  }

  @override
  Future<UserEntity> register({required String name, required String email, required String password, required String phone}) async{
    try {
      var response = await dataSource.register(name: name, email: email, password: password, phone: phone);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(response.data);
        return authResponse.toEntity();
      } else {
        throw response.data["message"];
      }
    } on DioException catch (e) {
      throw e.response?.data["message"];
    } catch (e, s) {
      print(e);
      print(s);
      throw e.toString();
    }
  }
}

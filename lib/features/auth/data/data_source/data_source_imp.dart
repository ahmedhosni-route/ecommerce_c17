import 'package:dio/src/response.dart';
import 'package:ecommerce_app/core/services/network_service.dart';
import 'package:ecommerce_app/features/auth/data/data_source/data_source.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: AuthDataSource )
class AuthDataSourceImp implements AuthDataSource {
  NetworkService networkService;
  AuthDataSourceImp(this.networkService);

  @override
  Future<Response> login({required String email, required String password}) {
    return networkService.dio
        .post("auth/signin", data: {"email": email, "password": password});
  }

  @override
  Future<Response> register(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    return networkService.dio.post("auth/signup", data: {
      "name": name,
      "email": email,
      "password": password,
      "rePassword": password,
      "phone": phone
    });
  }
}

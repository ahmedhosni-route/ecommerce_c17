import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class NetworkService {
  NetworkService() {
    dioInit();
  }
  late Dio dio;

  void dioInit() {
    dio = Dio(BaseOptions(
      baseUrl: "https://ecommerce.routemisr.com/api/v1/",
    ));
    getToken();
    dio.interceptors.add(
        PrettyDioLogger(request: true, requestBody: true, responseBody: true));
  }

  Future<void> updateToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    dio.options.headers.addAll({"token": token});
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (token != null) {
      dio.options.headers.addAll({"token": token});
    }
  }
}

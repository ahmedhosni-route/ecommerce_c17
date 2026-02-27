import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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
    dio.interceptors.add(
        PrettyDioLogger(request: true, requestBody: true, responseBody: true));
  }
}

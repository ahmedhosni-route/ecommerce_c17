import 'package:dio/dio.dart';

abstract class AuthDataSource{
  Future<Response> login({required String email , required String password});
  Future<Response> register({required String name,required String email , required String password,required String phone});
}
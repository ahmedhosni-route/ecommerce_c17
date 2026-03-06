import 'package:dio/dio.dart';

abstract class ProductDataSource{
  Future<Response> getProducts(String id);
  Future<Response> addFav(String id);
}
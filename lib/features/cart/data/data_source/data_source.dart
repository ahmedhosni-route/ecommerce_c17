import 'package:dio/dio.dart';

abstract class CartDataSource{
  Future<Response> getCart();
  Future<Response> addToCart(String id);
  Future<Response> updateCount(String id,int count);

}
import 'package:dio/src/response.dart';
import 'package:ecommerce_app/core/services/network_service.dart';
import 'package:ecommerce_app/features/cart/data/data_source/data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartDataSource)
class CartDataSourceImp implements CartDataSource {
  NetworkService networkService;
  CartDataSourceImp(this.networkService);

  @override
  Future<Response> getCart() {
    return networkService.dio.get("cart");
  }

  @override
  Future<Response> addToCart(String id) {
    return networkService.dio.post("cart", data: {"productId": id});
  }

  @override
  Future<Response> updateCount(String id, int count) {
    return networkService.dio.put("cart/$id", data: {"count": count});
  }
}

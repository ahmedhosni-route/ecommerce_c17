import 'package:ecommerce_app/features/cart/data/models/cart_response.dart';

import '../../../../core/services/api_response.dart';

abstract class CartRepo{
  Future<ApiResponse<String>> addToCart(String id);
  Future<ApiResponse<CartResponse>> getCart();
  Future<ApiResponse<String>> updateCount(String id, int count);


}
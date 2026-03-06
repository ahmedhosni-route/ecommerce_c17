import 'package:ecommerce_app/core/services/api_response.dart';
import 'package:ecommerce_app/features/products_screen/data/models/product_response.dart';

abstract class ProductRepo{
  Future<ApiResponse<List<Product>>> getProducts(String id);
  Future<ApiResponse<String>> addFav(String id);


}
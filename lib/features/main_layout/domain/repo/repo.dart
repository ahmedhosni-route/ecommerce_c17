import 'package:ecommerce_app/core/services/api_response.dart';
import 'package:ecommerce_app/features/main_layout/data/models/category_response.dart';
import 'package:ecommerce_app/features/products_screen/data/models/product_response.dart';

abstract class MainRepo{
  Future<ApiResponse<List<ProductCategory>>> getCategory();
  Future<ApiResponse<List<Product>>> getFav();
  Future<ApiResponse<String>> removeFav(String id);


}
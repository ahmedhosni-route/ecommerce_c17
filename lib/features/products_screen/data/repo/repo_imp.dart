import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/services/api_response.dart';
import 'package:ecommerce_app/features/products_screen/data/data_source/data_source.dart';

import 'package:ecommerce_app/features/products_screen/data/models/product_response.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo/repo.dart';

@Injectable(as: ProductRepo)
class ProductRepoImp implements ProductRepo {
  ProductDataSource dataSource;
  ProductRepoImp(this.dataSource);

  @override
  Future<ApiResponse<List<Product>>> getProducts(String id) async {
    try {
      var response = await dataSource.getProducts(id);

      if (response.statusCode == 200) {
        var data = ProductResponse.fromJson(response.data);
        return ApiSuccess(data.data ?? []);
      } else {
        return ApiError(response.data["message"] ?? "");
      }
    } on DioException catch (e) {
      return ApiError(e.response?.data["message"] ?? "");
    } catch (e) {
      return ApiError(e.toString());
    }
  }

  @override
  Future<ApiResponse<String>> addFav(String id) async {
    try {
      var response = await dataSource.addFav(id);

      if (response.statusCode == 200) {
        return ApiSuccess(response.data["message"] ?? "");
      } else {
        return ApiError(response.data["message"] ?? "");
      }
    } on DioException catch (e) {
      return ApiError(e.response?.data["message"] ?? "");
    } catch (e) {
      return ApiError(e.toString());
    }
  }

}

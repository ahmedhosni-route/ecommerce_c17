import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/services/api_response.dart';
import 'package:ecommerce_app/features/main_layout/data/data_source/data_source_imp.dart';
import 'package:ecommerce_app/features/main_layout/data/models/category_response.dart';
import 'package:ecommerce_app/features/main_layout/domain/repo/repo.dart';
import 'package:ecommerce_app/features/products_screen/data/models/product_response.dart';
import 'package:injectable/injectable.dart';

import '../data_source/data_source.dart';

@Injectable(as: MainRepo)
class MainRepoImp implements MainRepo {
  MainDataSource dataSource;

  MainRepoImp(this.dataSource);

  @override
  Future<ApiResponse<List<ProductCategory>>> getCategory() async {
    try {
      var response = await dataSource.getCategory();

      if (response.statusCode == 200) {
        var data = CategoryResponse.fromJson(response.data);
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
  Future<ApiResponse<List<Product>>> getFav() async {
    try {
      List<Product> products = [];
      var response = await dataSource.getFav();

      if (response.statusCode == 200) {
        for (var e in response.data["data"]) {
          products.add(Product.fromJson(e));
        }
        return ApiSuccess(products ?? []);
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
  Future<ApiResponse<String>> removeFav(String id) async {
    try {
      var response = await dataSource.removeFav(id);

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

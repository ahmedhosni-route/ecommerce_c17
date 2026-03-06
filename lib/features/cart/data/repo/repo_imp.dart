import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/cart/data/data_source/data_source.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_response.dart';
import 'package:ecommerce_app/features/cart/data/repo/repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/api_response.dart';

@Injectable(as: CartRepo)
class CartRepoImp implements CartRepo {
  CartDataSource dataSource;
  CartRepoImp(this.dataSource);

  @override
  Future<ApiResponse<String>> addToCart(String id) async {
    try {
      var response = await dataSource.addToCart(id);

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

  @override
  Future<ApiResponse<CartResponse>> getCart() async {
    try {
      var response = await dataSource.getCart();
      if (response.statusCode == 200) {
        var data = CartResponse.fromJson(response.data);
        return ApiSuccess(data);
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
  Future<ApiResponse<String>> updateCount(String id, int count)async {
    try {
      var response = await dataSource.updateCount(id,count);

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

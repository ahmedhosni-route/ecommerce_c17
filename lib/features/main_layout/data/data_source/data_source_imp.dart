import 'package:dio/src/response.dart';
import 'package:ecommerce_app/core/services/network_service.dart';
import 'package:ecommerce_app/features/main_layout/data/data_source/data_source.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: MainDataSource)
class MainDataSourceImp implements MainDataSource {

  MainDataSourceImp(this.networkService);
  NetworkService networkService;
  @override
  Future<Response> getCategory() {
    return networkService.dio.get("categories");
  }

  @override
  Future<Response> getFav() {
    return networkService.dio.get("wishlist");

  }

  @override
  Future<Response> removeFav(String id) {
    return networkService.dio.delete("wishlist/$id");
  }
}
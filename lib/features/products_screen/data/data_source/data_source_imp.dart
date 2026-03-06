import 'package:dio/src/response.dart';
import 'package:ecommerce_app/core/services/network_service.dart';
import 'package:ecommerce_app/features/products_screen/data/data_source/data_source.dart';
import 'package:injectable/injectable.dart';


@Injectable(as:ProductDataSource )
class ProductDataSourceImp implements ProductDataSource {
  NetworkService networkService;
  ProductDataSourceImp(this.networkService);

  @override
  Future<Response> getProducts(String id) {
    return networkService.dio
        .get("products", queryParameters: {"category[in]": id});
  }

  @override
  Future<Response> addFav(String id) {
    return networkService.dio.post("wishlist",data: {
      "productId":id
    });
  }

}

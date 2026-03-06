import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/services/api_response.dart';
import 'package:ecommerce_app/features/products_screen/domain/repo/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../data/models/product_response.dart';

part 'product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.repo) : super(ProductInitial());

  ProductRepo repo;

  static ProductCubit get(context) => BlocProvider.of(context);


  Future<void> getProduct(String id) async {
    emit(GetProductLoadingState());
    var result = await repo.getProducts(id);
    switch (result) {
      case ApiSuccess<List<Product>>():
        emit(GetProductSuccessState(result.data));
      case ApiError<List<Product>>():
        emit(GetProductErrorState(result.message));
    }
  }

  Future<void> addFav(String id) async {
    emit(AddFavLoadingState());

    var result = await repo.addFav(id);

    switch (result) {
      case ApiSuccess<String>():
        emit(AddFavSuccessState(result.data));
      case ApiError<String>():
        emit(AddFavErrorState(result.message));
    }
  }
}

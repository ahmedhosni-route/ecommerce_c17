import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/services/api_response.dart';
import 'package:ecommerce_app/features/main_layout/data/models/category_response.dart';
import 'package:ecommerce_app/features/main_layout/domain/repo/repo.dart';
import 'package:ecommerce_app/features/products_screen/data/models/product_response.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'main_state.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  MainCubit(this.repo) : super(MainInitial());

  MainRepo repo;

  Future<void> getCategory() async {
    emit(GetCategoryLoadingState());
    var result = await repo.getCategory();
    switch (result) {
      case ApiSuccess<List<ProductCategory>>():
        emit(GetCategorySuccessState(result.data));
      case ApiError<List<ProductCategory>>():
        emit(GetCategoryErrorState(result.message));
    }
  }

  Future<void> getFav() async {
    emit(GetFavLoadingState());
    var result = await repo.getFav();
    switch (result) {
      case ApiSuccess<List<Product>>():
        emit(GetFavSuccessState(result.data));
      case ApiError<List<Product>>():
        emit(GetFavErrorState(result.message));
    }
  }

  Future<void> removeFav(String id) async {
    emit(RemoveFavLoadingState());

    var result = await repo.removeFav(id);

    switch (result) {
      case ApiSuccess<String>():
        emit(RemoveFavSuccessState(result.data));
        getFav();
      case ApiError<String>():
        emit(RemoveFavErrorState(result.message));
    }
  }
}

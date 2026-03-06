part of 'main_cubit.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

class GetCategoryLoadingState extends MainState{}
final class GetCategorySuccessState extends MainState{
  List<ProductCategory> categories;
  GetCategorySuccessState(this.categories);
}
final class GetCategoryErrorState extends MainState{
  String message;
  GetCategoryErrorState(this.message);
}


class GetFavLoadingState extends MainState{}
final class GetFavSuccessState extends MainState{
  List<Product> products;
  GetFavSuccessState(this.products);
}
final class GetFavErrorState extends MainState{
  String message;
  GetFavErrorState(this.message);
}


class RemoveFavLoadingState extends MainState{}
final class RemoveFavSuccessState extends MainState{
  String message;
  RemoveFavSuccessState(this.message);
}
final class RemoveFavErrorState extends MainState{
  String message;
  RemoveFavErrorState(this.message);
}




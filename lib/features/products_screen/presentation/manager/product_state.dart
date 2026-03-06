part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class GetProductLoadingState extends ProductState{}
final class GetProductSuccessState extends ProductState{
  final List<Product> products;
  GetProductSuccessState(this.products);
}
final class GetProductErrorState extends ProductState{
  final String message;
  GetProductErrorState(this.message);
}


final class AddFavLoadingState extends ProductState{}
final class AddFavSuccessState extends ProductState{
  final String message;
  AddFavSuccessState(this.message);
}
final class AddFavErrorState extends ProductState{
  final String message;
  AddFavErrorState(this.message);
}




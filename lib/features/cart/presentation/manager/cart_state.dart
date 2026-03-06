part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class GetCartLoadingState extends CartState{}
final class GetCartSuccessState extends CartState{
  CartResponse cart;
  GetCartSuccessState(this.cart);
}
final class GetCartErrorState extends CartState{
  final String message;
  GetCartErrorState(this.message);
}


final class AddCartLoadingState extends CartState{}
final class AddCartSuccessState extends CartState{
  final String message;
  AddCartSuccessState(this.message);
}
final class AddCartErrorState extends CartState{
  final String message;
  AddCartErrorState(this.message);
}


final class UpdateCartLoadingState extends CartState{}
final class UpdateCartSuccessState extends CartState{
  final String message;
  UpdateCartSuccessState(this.message);
}
final class UpdateCartErrorState extends CartState{
  final String message;
  UpdateCartErrorState(this.message);
}
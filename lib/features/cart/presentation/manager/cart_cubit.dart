import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_response.dart';
import 'package:ecommerce_app/features/cart/data/repo/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/services/api_response.dart';

part 'cart_state.dart';

@Singleton()
class CartCubit extends Cubit<CartState> {
  CartCubit(this.repo) : super(CartInitial());


  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);

  CartRepo repo;

  CartResponse? cart;

  Future<void> addCart(String id) async {
    emit(AddCartLoadingState());

    var result = await repo.addToCart(id);

    switch (result) {
      case ApiSuccess<String>():
        emit(AddCartSuccessState(result.data));
      case ApiError<String>():
        emit(AddCartErrorState(result.message));
    }
  }


  Future<void> getCart()async{
    emit(GetCartLoadingState());

    var result = await repo.getCart();

    switch(result) {
      case ApiSuccess<CartResponse>():
        cart = result.data;
        emit(GetCartSuccessState(result.data));
        case ApiError<CartResponse>():
          emit(GetCartErrorState(result.message));
    }
  }


  Future<void> updateCount(String id,int count) async {
    emit(UpdateCartLoadingState());

    var result = await repo.updateCount(id,count);

    switch (result) {
      case ApiSuccess<String>():
        emit(UpdateCartSuccessState(result.data));
        getCart();
      case ApiError<String>():
        emit(UpdateCartErrorState(result.message));
    }
  }




}

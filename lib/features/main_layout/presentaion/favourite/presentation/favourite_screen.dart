import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/main_layout/presentaion/favourite/presentation/widgets/favourite_item.dart';
import 'package:ecommerce_app/features/main_layout/presentaion/manager/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends StatefulWidget {
  MainCubit cubit;
  FavouriteScreen({super.key, required this.cubit});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    widget.cubit.getFav();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        if (state is GetFavSuccessState) {
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.s14.w, vertical: AppSize.s10.h),
              child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSize.s12.h),
                    child: FavoriteItem(product: state.products[index]),
                  );
                },
              ));
        } else if (state is GetFavErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GetFavLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      },
      buildWhen: (previous, current) {
        return (current is GetFavSuccessState ||
            current is GetFavErrorState ||
            current is GetFavLoadingState);
      },
    );
  }
}

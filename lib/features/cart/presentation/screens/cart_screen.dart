import 'package:ecommerce_app/core/config/getIt_config.dart';
import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/cart_item_widget.dart';
import '../widgets/total_price_and_checkout_botton.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    getIt<CartCubit>().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        var cubit = CartCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Cart',
              style: getMediumStyle(
                  fontSize: 20, color: ColorManager.textColor),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage(
                    IconsAssets.icSearch,
                  ),
                  color: ColorManager.primary,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage(IconsAssets.icCart),
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: Column(
              children: [
                Expanded(
                  // the list of cart items ===============
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var product = cubit.cart?.data?.products?[index];
                      return CartItemWidget(
                          imagePath: product?.product?.imageCover??"",
                          title: product?.product?.title??"",
                          price: product?.price?.toInt()??0,
                          quantity: product?.count?.toInt()??0,
                          onDeleteTap: () {},
                          onDecrementTap: (value) {
                            int count = --value;

                            cubit.updateCount(product!.product!.id!, count);
                          },
                          onIncrementTap: (value) {
                            int count = ++value;
                            cubit.updateCount(product!.product!.id!, count);

                          },
                          size: 40,
                          color: Colors.black,
                          colorName: 'Black',
                        );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: AppSize.s12.h),
                    itemCount: cubit.cart?.data?.products?.length??0,
                  ),
                ),
                // the total price and checkout button========
                TotalPriceAndCheckoutBotton(
                  totalPrice: cubit.cart?.data?.totalCartPrice?.toInt()??0,
                  checkoutButtonOnTap: () {},
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

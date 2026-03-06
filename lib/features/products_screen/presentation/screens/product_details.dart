import 'package:ecommerce_app/core/config/getIt_config.dart';
import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/services/loading_service.dart';
import 'package:ecommerce_app/core/services/toast_service.dart';
import 'package:ecommerce_app/core/widget/custom_elevated_button.dart';
import 'package:ecommerce_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:ecommerce_app/features/products_screen/data/models/product_response.dart';
import 'package:ecommerce_app/features/products_screen/presentation/manager/product_cubit.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/product_description.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/product_item.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/product_label.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/product_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widget/product_counter.dart';
import '../widgets/product_color.dart';
import '../widgets/product_rating.dart' show ProductRating;
import '../widgets/product_size.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  ProductDetails({super.key, required this.product});

  ValueNotifier<int> count = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductCubit>(),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is AddFavLoadingState) {
            Loading.show(context);
          } else if (state is AddFavSuccessState) {
            Loading.hide(context);
            Toast.showToast(context: context, message: state.message);
          } else if (state is AddFavErrorState) {
            Loading.hide(context);
            Toast.showToast(
                context: context,
                message: state.message,
                type: ToastType.error);
          }
        },
        builder: (ctx, state) {
          var cubit = ProductCubit.get(ctx);
          return Scaffold(
            bottomNavigationBar: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total price',
                        style: getMediumStyle(
                                color: ColorManager.primary.withOpacity(.6))
                            .copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      ValueListenableBuilder(
                        valueListenable: count,
                        builder: (context, value, child) {
                          return Text('EGP ${product.price! * value}',
                              style: getMediumStyle(
                                      color: ColorManager.appBarTitleColor)
                                  .copyWith(fontSize: 18.sp));
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    width: 33.w,
                  ),
                  Expanded(
                    child: CustomElevatedButton(
                      label: 'Add to cart',
                      onTap: () {
                        getIt<CartCubit>().addCart(product.id!);
                      },
                      prefixIcon: Icon(
                        Icons.add_shopping_cart_outlined,
                        color: ColorManager.white,
                      ),
                    ),
                  )
                ],
              ),
            )),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Product Details',
                style: getMediumStyle(color: ColorManager.appBarTitleColor)
                    .copyWith(fontSize: 20.sp),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: ImageIcon(
                      AssetImage(IconsAssets.icSearch),
                      color: ColorManager.primary,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: ColorManager.primary,
                    )),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 50.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductSlider(
                          items: (product.images ?? []).map(
                            (e) {
                              return ProductItem(
                                imageUrl: e,
                                onTap: () {
                                  cubit.addFav(product.id!);
                                },
                              );
                            },
                          ).toList(),
                          initialIndex: 0),
                      SizedBox(
                        height: 24.h,
                      ),
                      ProductLabel(
                          productName: product.title ?? "",
                          productPrice: 'EGP ${product.price}'),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ProductRating(
                                productBuyers: '${product.sold}',
                                productRating:
                                    '${product.ratingsAverage} (${product.ratingsQuantity})'),
                          ),
                          ValueListenableBuilder(
                            valueListenable: count,
                            builder: (context, value, child) {
                              return ProductCounter(
                                  add: (_) {
                                    count.value++;
                                  },
                                  remove: (_) {
                                    if (count.value == 1) return;
                                    count.value--;
                                  },
                                  productCounter: count.value);
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ProductDescription(
                          productDescription: product.description ?? ""),
                      // ProductSize(
                      //   size: [35, 38, 39, 40],
                      //   onSelected: () {},
                      // ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      // Text('Color',
                      //     style: getMediumStyle(color: ColorManager.appBarTitleColor)
                      //         .copyWith(fontSize: 18.sp)),
                      // ProductColor(color:  [
                      //   Colors.red,
                      //   Colors.blueAccent,
                      //   Colors.green,
                      //   Colors.yellow,
                      // ], onSelected: () {}),
                      SizedBox(
                        height: 48.h,
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

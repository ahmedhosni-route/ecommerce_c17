import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/products_screen/presentation/manager/product_cubit.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/custom_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/getIt_config.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../../core/widget/home_screen_app_bar.dart';

class ProductsScreen extends StatelessWidget {
 final String id;
  const ProductsScreen({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => getIt<ProductCubit>()..getProduct(id),
      child: Scaffold(
        appBar: const HomeScreenAppBar(
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ProductCubit , ProductState>(
                  builder: (context, state) {
                    if(state is GetProductLoadingState){
                      return const Center(child: CircularProgressIndicator(),);
                    }else if(state is GetProductSuccessState){
                      var products = state.products??[];
                      return GridView.builder(
                        itemCount: products.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 6.5 / 9,
                        ),
                        itemBuilder: (context, index) {
                          var product = products[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.productDetails,arguments: product);
                            },
                            child: CustomProductWidget(
                              id: product.id!,
                              image: product.imageCover??"",
                              title: product.title??"",
                              price: product.price?.toDouble()??0,
                              rating: product.ratingsAverage?.toDouble()??0,
                              discountPercentage: 0,
                              height: height,
                              width: width,
                              description:
                              product.description??"",
                            ),
                          );
                        },
                        scrollDirection: Axis.vertical,
                      );
                    }else if(state is GetProductErrorState){
                      return Center(child: Text(state.message),);
                    }
                    return const SizedBox();
                  },
                  buildWhen: (previous, current) {
                    return current is GetProductSuccessState ||
                    current is GetProductLoadingState||
                    current is GetProductErrorState;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

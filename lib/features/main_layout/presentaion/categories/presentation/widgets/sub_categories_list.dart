import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/routes_manager/routes.dart';
import '../../../manager/main_cubit.dart';
import 'category_card_item.dart' show CategoryCardItem;
import 'sub_category_item.dart';

class SubCategoriesList extends StatelessWidget {
  const SubCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: CustomScrollView(
        slivers: <Widget>[
          // category title
          SliverToBoxAdapter(
            child: Text(
              'Laptops & Electronics',
              style: getBoldStyle(
                  color: ColorManager.primary, fontSize: FontSize.s14),
            ),
          ),
          // the category card
          SliverToBoxAdapter(
            child: CategoryCardItem("Laptops & Electronics",
                ImageAssets.categoryCardImage, goToCategoryProductsListScreen),
          ),
          // the grid view of the subcategories

          BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              print(state);
              if (state is GetCategoryLoadingState) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is GetCategorySuccessState) {
                var categories = state.categories ?? [];
                return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: categories.length,
                      (context, index) => InkWell(
                        onTap: () => Navigator.pushNamed(context, Routes.productsScreenRoute,arguments: categories[index].id.toString()),

                        child: SubCategoryItem(
                            categories[index].name??"",
                            categories[index].image??"",
                            goToCategoryProductsListScreen),
                      ),
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: AppSize.s8,
                      crossAxisSpacing: AppSize.s8,
                    ));
              } else if (state is GetCategoryErrorState) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox());
            },
            buildWhen: (previous, current) {
              return (current is GetCategorySuccessState ||
                  current is GetCategoryLoadingState ||
                  current is GetCategoryErrorState);
            },
          ),
        ],
      ),
    );
  }

  goToCategoryProductsListScreen() {
    // todo implement this function
  }
}

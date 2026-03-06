import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/main_layout/presentaion/categories/presentation/widgets/categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/main_cubit.dart';
import 'widgets/sub_categories_list.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {

  @override
  void initState() {
    context.read<MainCubit>().getCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p12, vertical: AppPadding.p12),
      child: Row(
        children: [
          // CategoriesList(),
          // SizedBox(
          //   width: AppSize.s16,
          // ),
          SubCategoriesList()
        ],
      ),
    );
  }
}

import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ecommerce_app/features/main_layout/main_layout.dart';
import 'package:ecommerce_app/features/products_screen/data/models/product_response.dart';
import 'package:ecommerce_app/features/products_screen/presentation/screens/product_details.dart';
import 'package:ecommerce_app/features/products_screen/presentation/screens/products_screen.dart';
import 'package:flutter/material.dart';

import '../../features/cart/presentation/screens/cart_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainLayout());

      case Routes.productsScreenRoute:
        String id = settings.arguments as String ;
        return MaterialPageRoute(builder: (_) =>  ProductsScreen(id:id ,),settings: settings);

      case Routes.productDetails:
        Product product = settings.arguments as Product;
        return MaterialPageRoute(builder: (_) =>  ProductDetails(product:product));

      case Routes.signInRoute:
        return MaterialPageRoute(builder: (_) =>  SignInScreen());

      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) =>  SignUpScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}

import 'package:ecommerce_app/core/config/getIt_config.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/routes_manager/route_generator.dart';
import 'core/services/loading_service.dart';
import 'core/services/toast_service.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  configureDependencies();
  runApp(MainApp(
    token: token,
  ));
}

class MainApp extends StatelessWidget {
  String? token;

  MainApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CartCubit>()..getCart(),
      child: BlocListener<CartCubit, CartState>(
        listener: (_, state) {
          if (state is AddCartLoadingState) {
            Loading.show();
          } else if (state is AddCartSuccessState) {
            Loading.hide();
            Toast.showToast(
                context: navigatorKey.currentContext!, message: state.message);
          } else if (state is AddCartErrorState) {
            Loading.hide();
            Toast.showToast(
                context: navigatorKey.currentContext!,
                message: state.message,
                type: ToastType.error);
          }

          if (state is UpdateCartLoadingState) {
            Loading.show();
          } else if (state is UpdateCartSuccessState) {
            Loading.hide();
            Toast.showToast(
                context: navigatorKey.currentContext!, message: state.message);
          } else if (state is UpdateCartErrorState) {
            Loading.hide();
            Toast.showToast(
                context: navigatorKey.currentContext!,
                message: state.message,
                type: ToastType.error);
          }
        },
        child: ScreenUtilInit(
          designSize: const Size(430, 932),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            home: child,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: token != null ? Routes.mainRoute : Routes.signInRoute,
          ),
        ),
      ),
    );
  }
}

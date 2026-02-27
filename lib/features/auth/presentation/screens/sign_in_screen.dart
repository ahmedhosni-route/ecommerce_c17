import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/core/services/loading_service.dart';
import 'package:ecommerce_app/core/services/network_service.dart';
import 'package:ecommerce_app/core/services/toast_service.dart';
import 'package:ecommerce_app/core/widget/custom_elevated_button.dart';
import 'package:ecommerce_app/core/widget/main_text_field.dart';
import 'package:ecommerce_app/core/widget/validators.dart';
import 'package:ecommerce_app/features/auth/data/data_source/data_source_imp.dart';
import 'package:ecommerce_app/features/auth/data/repo/repo_imp.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:ecommerce_app/features/auth/presentation/manager/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/config/getIt_config.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: ColorManager.primary,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: SingleChildScrollView(
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LoginLoadingState) {
                      Loading.show(context);
                    } else if (state is LoginErrorState) {
                      Loading.hide(context);
                      Toast.showToast(
                          context: context,
                          message: state.error,
                          type: ToastType.error);
                    } else if (state is LoginSuccessState) {
                      Loading.hide(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.mainRoute, (route) => false);
                      Toast.showToast(
                          context: context,
                          message: "Login Success",
                          type: ToastType.success);
                    }
                  },
                  builder: (context, state) {
                    var cubit = AuthCubit.get(context);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppSize.s40.h,
                        ),
                        Center(child: SvgPicture.asset(SvgAssets.routeLogo)),
                        SizedBox(
                          height: AppSize.s40.h,
                        ),
                        Text(
                          'Welcome Back To Route',
                          style: getBoldStyle(color: ColorManager.white)
                              .copyWith(fontSize: FontSize.s24.sp),
                        ),
                        Text(
                          'Please sign in with your mail',
                          style: getLightStyle(color: ColorManager.white)
                              .copyWith(fontSize: FontSize.s16.sp),
                        ),
                        SizedBox(
                          height: AppSize.s50.h,
                        ),
                        BuildTextField(
                          controller: cubit.emailController,
                          backgroundColor: ColorManager.white,
                          hint: 'enter your name',
                          label: 'User name',
                          textInputType: TextInputType.emailAddress,
                          validation: AppValidators.validateEmail,
                        ),
                        SizedBox(
                          height: AppSize.s28.h,
                        ),
                        BuildTextField(
                          controller: cubit.passwordController,
                          hint: 'enter your password',
                          backgroundColor: ColorManager.white,
                          label: 'Password',
                          validation: AppValidators.validatePassword,
                          isObscured: true,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: AppSize.s8.h,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Forget password?',
                                  style:
                                      getMediumStyle(color: ColorManager.white)
                                          .copyWith(fontSize: FontSize.s18.sp),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: AppSize.s60.h,
                        ),
                        Center(
                          child: SizedBox(
                            // width: MediaQuery.of(context).size.width * .8,
                            child: CustomElevatedButton(
                              // borderRadius: AppSize.s8,
                              isStadiumBorder: false,
                              label: 'Login',
                              backgroundColor: ColorManager.white,
                              textStyle: getBoldStyle(
                                  color: ColorManager.primary,
                                  fontSize: AppSize.s18),
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.login();
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account?',
                              style: getSemiBoldStyle(color: ColorManager.white)
                                  .copyWith(fontSize: FontSize.s16.sp),
                            ),
                            SizedBox(
                              width: AppSize.s8.w,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, Routes.signUpRoute),
                              child: Text(
                                'Create Account',
                                style:
                                    getSemiBoldStyle(color: ColorManager.white)
                                        .copyWith(fontSize: FontSize.s16.sp),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

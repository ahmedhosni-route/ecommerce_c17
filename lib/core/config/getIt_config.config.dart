// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_source/data_source.dart' as _i201;
import '../../features/auth/data/data_source/data_source_imp.dart' as _i690;
import '../../features/auth/data/repo/repo_imp.dart' as _i202;
import '../../features/auth/domain/repo/repo.dart' as _i31;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/register_use_case.dart' as _i1010;
import '../../features/auth/presentation/manager/auth_cubit.dart' as _i888;
import '../../features/cart/data/data_source/data_source.dart' as _i314;
import '../../features/cart/data/data_source/data_source_imp.dart' as _i957;
import '../../features/cart/data/repo/repo.dart' as _i937;
import '../../features/cart/data/repo/repo_imp.dart' as _i788;
import '../../features/cart/presentation/manager/cart_cubit.dart' as _i680;
import '../../features/main_layout/data/data_source/data_source.dart' as _i419;
import '../../features/main_layout/data/data_source/data_source_imp.dart'
    as _i219;
import '../../features/main_layout/data/repo/repo_imp.dart' as _i997;
import '../../features/main_layout/domain/repo/repo.dart' as _i1025;
import '../../features/main_layout/presentaion/manager/main_cubit.dart'
    as _i881;
import '../../features/products_screen/data/data_source/data_source.dart'
    as _i665;
import '../../features/products_screen/data/data_source/data_source_imp.dart'
    as _i670;
import '../../features/products_screen/data/repo/repo_imp.dart' as _i599;
import '../../features/products_screen/domain/repo/repo.dart' as _i1016;
import '../../features/products_screen/presentation/manager/product_cubit.dart'
    as _i65;
import '../services/network_service.dart' as _i463;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i463.NetworkService>(() => _i463.NetworkService());
    gh.factory<_i665.ProductDataSource>(
        () => _i670.ProductDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i314.CartDataSource>(
        () => _i957.CartDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i419.MainDataSource>(
        () => _i219.MainDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i201.AuthDataSource>(
        () => _i690.AuthDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i937.CartRepo>(
        () => _i788.CartRepoImp(gh<_i314.CartDataSource>()));
    gh.factory<_i1016.ProductRepo>(
        () => _i599.ProductRepoImp(gh<_i665.ProductDataSource>()));
    gh.singleton<_i680.CartCubit>(() => _i680.CartCubit(gh<_i937.CartRepo>()));
    gh.factory<_i31.AuthRepo>(
        () => _i202.AuthRepoImp(gh<_i201.AuthDataSource>()));
    gh.factory<_i1025.MainRepo>(
        () => _i997.MainRepoImp(gh<_i419.MainDataSource>()));
    gh.factory<_i65.ProductCubit>(
        () => _i65.ProductCubit(gh<_i1016.ProductRepo>()));
    gh.factory<_i1038.LoginUseCase>(
        () => _i1038.LoginUseCase(gh<_i31.AuthRepo>()));
    gh.factory<_i1010.RegisterUseCase>(
        () => _i1010.RegisterUseCase(gh<_i31.AuthRepo>()));
    gh.factory<_i881.MainCubit>(() => _i881.MainCubit(gh<_i1025.MainRepo>()));
    gh.factory<_i888.AuthCubit>(() => _i888.AuthCubit(
          gh<_i1010.RegisterUseCase>(),
          gh<_i1038.LoginUseCase>(),
        ));
    return this;
  }
}

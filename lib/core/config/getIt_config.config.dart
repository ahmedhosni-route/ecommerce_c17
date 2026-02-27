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
    gh.factory<_i201.AuthDataSource>(
        () => _i690.AuthDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i31.AuthRepo>(
        () => _i202.AuthRepoImp(gh<_i201.AuthDataSource>()));
    gh.factory<_i1038.LoginUseCase>(
        () => _i1038.LoginUseCase(gh<_i31.AuthRepo>()));
    gh.factory<_i1010.RegisterUseCase>(
        () => _i1010.RegisterUseCase(gh<_i31.AuthRepo>()));
    gh.factory<_i888.AuthCubit>(() => _i888.AuthCubit(
          gh<_i1010.RegisterUseCase>(),
          gh<_i1038.LoginUseCase>(),
        ));
    return this;
  }
}

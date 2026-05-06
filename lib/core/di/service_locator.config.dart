// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movie_app/core/di/dio/dio.dart' as _i405;
import 'package:movie_app/features/search/data/models/search_api.dart' as _i943;
import 'package:movie_app/features/search/data/repo/search_data_source_imp.dart'
    as _i81;
import 'package:movie_app/features/search/data/repo/search_repo_imp.dart'
    as _i409;
import 'package:movie_app/features/search/domain/repo/search_data_source.dart'
    as _i832;
import 'package:movie_app/features/search/domain/repo/search_repo.dart'
    as _i894;
import 'package:movie_app/features/search/domain/use_case/search_use_case.dart'
    as _i297;
import 'package:movie_app/features/search/presentation/view_model/search_cubit.dart'
    as _i341;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.singleton<_i943.ApiSearchService>(
      () => _i943.ApiSearchService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i832.SearchDataSource>(
      () => _i81.SearchDataSourceImp(gh<_i943.ApiSearchService>()),
    );
    gh.lazySingleton<_i894.SearchRepo>(
      () => _i409.SearchRepoImp(gh<_i832.SearchDataSource>()),
    );
    gh.factory<_i297.SearchUseCase>(
      () => _i297.SearchUseCase(searchRepo: gh<_i894.SearchRepo>()),
    );
    gh.factory<_i341.SearchCubit>(
      () => _i341.SearchCubit(searchRepo: gh<_i894.SearchRepo>()),
    );
    return this;
  }
}

class _$DioModule extends _i405.DioModule {}

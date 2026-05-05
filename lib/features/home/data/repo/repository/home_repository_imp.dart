import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/home/data/repo/data_source/home_data_source_imp.dart';
import 'package:movie_app/features/home/domain/entities/home_entity.dart';
import 'package:movie_app/features/home/domain/repo/data_source/home_data_source.dart';
import 'package:movie_app/features/home/domain/repo/repository/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeRepositoryImp(this._dataSource);
  final HomeDataSource _dataSource;
  @override
  Future<ApiResult<HomeEntity>> getPopularMovie() async {
    var result = await _dataSource.getPopularMovie();
    switch (result) {
      case ApiSuccess<HomeEntity>():
        return ApiSuccess<HomeEntity>(result.data);
      case ApiError<HomeEntity>():
        return ApiError<HomeEntity>(result.message);
    }
  }

  @override
  Future<ApiResult<HomeEntity>> getTopRatedMovie() async {
    var result = await _dataSource.getTopRatedMovie();
    switch (result) {
      case ApiSuccess<HomeEntity>():
        return ApiSuccess<HomeEntity>(result.data);
      case ApiError<HomeEntity>():
        return ApiError<HomeEntity>(result.message);
    }
  }

  @override
  Future<ApiResult<HomeEntity>> getReleaseRatedMovie() async {
    var result = await _dataSource.getReleasedMovie();
    switch (result) {
      case ApiSuccess<HomeEntity>():
        return ApiSuccess<HomeEntity>(result.data);
      case ApiError<HomeEntity>():
        return ApiError<HomeEntity>(result.message);
    }
  }
}

HomeRepository homeRepositoryInjectable() =>
    HomeRepositoryImp(homeDataSourceInjectable());

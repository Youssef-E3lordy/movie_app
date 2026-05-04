import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/popular/domain/entities/popular_entity.dart';
import 'package:movie_app/features/popular/domain/repo/data_source/popular_movie_data_source.dart';
import 'package:movie_app/features/popular/domain/repo/repository/popular_movie_repository.dart';

class PopularMovieRepositoryImp implements PopularMovieRepository {
  PopularMovieRepositoryImp(this._dataSource);
  final PopularMovieDataSource _dataSource;

  @override
  Future<ApiResult<PopularEntity>> getPopularMovie() async {
    try {
      var result = await _dataSource.getPopularMovie();
      switch (result) {
        case ApiSuccess<PopularEntity>():
          return ApiSuccess<PopularEntity>(result.data);
        case ApiError<PopularEntity>():
          return ApiError<PopularEntity>(result.message);
      }
    } catch (e) {
      return ApiError<PopularEntity>(e.toString());
    }
  }
}

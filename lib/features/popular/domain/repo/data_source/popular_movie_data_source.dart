import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/popular/domain/entities/popular_entity.dart';

abstract interface class PopularMovieDataSource {
  Future<ApiResult<PopularEntity>> getPopularMovie();
}

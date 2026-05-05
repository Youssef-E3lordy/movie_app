import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/home/domain/entities/home_entity.dart';

abstract interface class HomeDataSource {
  Future<ApiResult<HomeEntity>> getPopularMovie();
  Future<ApiResult<HomeEntity>> getTopRatedMovie();
}

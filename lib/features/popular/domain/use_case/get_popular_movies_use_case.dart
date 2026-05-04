import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/popular/domain/entities/popular_entity.dart';
import 'package:movie_app/features/popular/domain/repo/repository/popular_movie_repository.dart';

class GetPopularMoviesUseCase {
  GetPopularMoviesUseCase(this._repository);
  final PopularMovieRepository _repository;
  Future<ApiResult<PopularEntity>> invoke() => _repository.getPopularMovie();
}

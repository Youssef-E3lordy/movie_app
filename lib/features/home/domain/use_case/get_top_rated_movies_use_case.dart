import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/home/data/repo/repository/home_repository_imp.dart';
import 'package:movie_app/features/home/domain/entities/home_entity.dart';
import 'package:movie_app/features/home/domain/repo/repository/home_repository.dart';

class GetTopRatedMoviesUseCase {
  HomeRepository _repository;
  GetTopRatedMoviesUseCase(this._repository);
  Future<ApiResult<HomeEntity>> invoke() async =>
      await _repository.getTopRatedMovie();
}

GetTopRatedMoviesUseCase getTopRatedMoviesUseCaseInjectable() {
  return GetTopRatedMoviesUseCase(homeRepositoryInjectable());
}

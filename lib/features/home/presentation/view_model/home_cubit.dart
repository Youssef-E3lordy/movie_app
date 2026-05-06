import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/home/domain/entities/home_entity.dart';
import 'package:movie_app/features/home/domain/use_case/get_popular_movies_use_case.dart';
import 'package:movie_app/features/home/domain/use_case/get_release_movies_use_case.dart';
import 'package:movie_app/features/home/domain/use_case/get_top_rated_movies_use_case.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
    required this.getReleaseMoviesUseCase,
  }) : super(Loading());
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetReleaseMoviesUseCase getReleaseMoviesUseCase;

  List<ResultsEntity> popularMovies = [];
  List<ResultsEntity> topRatedMovies = [];
  List<ResultsEntity> releaseRatedMovies = [];

  Future<void> getMovies() async {
    emit(Loading());
    var popularResult = await getPopularMoviesUseCase.invoke();
    var topRatedResult = await getTopRatedMoviesUseCase.invoke();
    var releaseRatedResult = await getReleaseMoviesUseCase.invoke();

    switch (popularResult) {
      case ApiSuccess(data: final data):
        popularMovies = data.results;
      case ApiError():
        popularMovies = [];
    }
    switch (topRatedResult) {
      case ApiSuccess(data: final data):
        topRatedMovies = data.results;
      case ApiError():
        topRatedMovies = [];
    }
    switch (releaseRatedResult) {
      case ApiSuccess(data: final data):
        releaseRatedMovies = data.results;
      case ApiError():
        releaseRatedMovies = [];
    }
    if (popularMovies.isEmpty &&
        topRatedMovies.isEmpty &&
        releaseRatedMovies.isEmpty) {
      emit(Error('Error Try Again'));
    } else {
      emit(
        Success(
          popularMovies: popularMovies,
          topRatedMovies: topRatedMovies,
          releaseRatedMovies: releaseRatedMovies,
        ),
      );
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/home/domain/entities/home_entity.dart';
import 'package:movie_app/features/home/domain/use_case/get_popular_movies_use_case.dart';
import 'package:movie_app/features/home/domain/use_case/get_top_rated_movies_use_case.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
  }) : super(Loading());
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  List<ResultsEntity> popularMovies = [];
  List<ResultsEntity> topRatedMovies = [];
  Future<void> getPopularMovies() async {
    emit(Loading());
    var popularResult = await getPopularMoviesUseCase.invoke();
    var topRatedResult = await getTopRatedMoviesUseCase.invoke();

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
    if (popularMovies.isEmpty && topRatedMovies.isEmpty) {
      emit(Error('Error Try Again'));
    } else {
      emit(
        Success(popularMovies: popularMovies, topRatedMovies: topRatedMovies),
      );
    }
  }
}

part of 'home_cubit.dart';

abstract class HomeState {}

class Loading extends HomeState {}

class Success extends HomeState {
  Success({
    required this.popularMovies,
    required this.topRatedMovies,
    required this.releaseRatedMovies,
  });
  List<ResultsEntity> popularMovies;
  List<ResultsEntity> topRatedMovies;
  List<ResultsEntity> releaseRatedMovies;
}

class Error extends HomeState {
  Error(this.errorMessage);
  String errorMessage;
}

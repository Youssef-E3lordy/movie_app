import 'package:movie_app/features/search/domain/entites/search_entity.dart';

abstract class SearchState {}

class InitialState extends SearchState {}

class LoadingState extends SearchState {}

class SuccessState extends SearchState {
  final List<MovieEntity> movies;

  SuccessState({required this.movies});
}

class ErrorState extends SearchState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}
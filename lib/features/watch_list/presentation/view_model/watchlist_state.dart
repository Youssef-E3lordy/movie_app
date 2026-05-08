import '../../../../core/local_storage/hive_models/movie_hive_model.dart';

sealed class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistSuccess extends WatchlistState {
  final List<MovieHiveModel> movies;
  WatchlistSuccess(this.movies);
}

class WatchlistError extends WatchlistState {
  final String message;
  WatchlistError(this.message);
}
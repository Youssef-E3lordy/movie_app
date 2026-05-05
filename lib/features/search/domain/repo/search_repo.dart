import 'package:movie_app/features/search/domain/entites/search_entity.dart';

abstract interface class SearchRepo {
  Future<SearchEntity> searchMovies(String query);
}
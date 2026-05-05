// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/features/search/domain/entites/search_entity.dart';
import 'package:movie_app/features/search/domain/repo/search_repo.dart';

class SearchUseCase {
  final SearchRepo searchRepo;
  SearchUseCase({required this.searchRepo});
  Future<SearchEntity> invoke(String query) => searchRepo.searchMovies(query);
}

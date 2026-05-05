import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/search/data/models/search_model.dart';


abstract interface class SearchDataSource {
  Future<ApiResult<SearchModel>> searchMovies(String query);
}
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/search/data/models/search_model_dto.dart';
abstract interface class SearchDataSource {
  Future<ApiResult<SearchModelDto>> searchMovies(String query);
}

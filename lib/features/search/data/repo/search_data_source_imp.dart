import 'package:movie_app/core/network/api_constant.dart';
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/search/data/models/search_api.dart';
import 'package:movie_app/features/search/data/models/search_model.dart';

import 'package:movie_app/features/search/domain/repo/search_data_source.dart';

class SearchDataSourceImp implements SearchDataSource {
  final ApiSearchService apiService;
  SearchDataSourceImp(this.apiService);
  @override
  Future<ApiResult<SearchModel>> searchMovies(String query) async {
    try {
      final response = await apiService.get(
        endpoint: ApiConstants.searchMoviesEndpoint,
        queryParameters: {"query": query},
      );
      final model = SearchModel.fromJson(response.data);
      return ApiSuccess(model);
    } catch (e) {
      return ApiError(e.toString());
    }
  }
}

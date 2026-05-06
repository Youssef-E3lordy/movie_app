import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/api_constant.dart';
import 'package:movie_app/core/network/api_error_handler.dart';
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/search/data/models/search_api.dart';
import 'package:movie_app/features/search/data/models/search_model_dto.dart';
import 'package:movie_app/features/search/domain/repo/search_data_source.dart';
@LazySingleton(as: SearchDataSource)
class SearchDataSourceImp implements SearchDataSource {
  final ApiSearchService apiService;
  SearchDataSourceImp(this.apiService);
  @override
  Future<ApiResult<SearchModelDto>> searchMovies(String query) async {
    try {
      final response = await apiService.get(
        endpoint: ApiConstants.searchMoviesEndpoint,
        queryParameters: {"query": query},
      );
      final model = SearchModelDto.fromJson(response.data);
      return ApiSuccess(model);
    } catch (e) {
      return ApiErrorHandler.handle(e);
    }
  }
}

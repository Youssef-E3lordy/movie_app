// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/search/data/mapper/search_mapper.dart';
import 'package:movie_app/features/search/data/models/search_model_dto.dart';
import 'package:movie_app/features/search/domain/entites/search_entity.dart';
import 'package:movie_app/features/search/domain/repo/search_data_source.dart';
import 'package:movie_app/features/search/domain/repo/search_repo.dart';
@LazySingleton(as:SearchRepo)
class SearchRepoImp implements SearchRepo {
  final SearchDataSource dataSource;

  SearchRepoImp(this.dataSource);

  @override
  Future<SearchEntity> searchMovies(String query) async {
    final result = await dataSource.searchMovies(query);
    switch (result) {
      case ApiSuccess<SearchModelDto>():
        return result.data.toEntity();
      case ApiError<SearchModelDto>():
        throw Exception(result.message);
    }
  }
}

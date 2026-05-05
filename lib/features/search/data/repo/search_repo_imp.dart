// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:movie_app/features/search/domain/entites/search_entity.dart';
import 'package:movie_app/features/search/domain/repo/search_data_source.dart';
import 'package:movie_app/features/search/domain/repo/search_repo.dart';

class SearchRepoImp implements SearchRepo {
  final SearchDataSource dataSource;

  SearchRepoImp(this.dataSource);
  
  @override
  Future<SearchEntity> searchMovies(String query) {
  final result=  dataSource.searchMovies(query);
  switch(result){
    case 
  }
  }

 
}

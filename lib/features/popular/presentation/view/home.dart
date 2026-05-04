import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/popular/data/api/get_popular_movies_api.dart';
import 'package:movie_app/features/popular/data/repo/data_source/popular_movie_data_source_imp.dart';
import 'package:movie_app/features/popular/data/repo/repository/popular_movie_repository_imp.dart';
import 'package:movie_app/features/popular/domain/use_case/get_popular_movies_use_case.dart';
import 'package:movie_app/features/popular/presentation/view_model/popular_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  late PopularCubit _cubit;
  void initState() {
    super.initState();
    var repo = PopularMovieRepositoryImp(
      PopularMovieDataSourceImp(GetPopularMoviesApi()),
    );
    var useCase = GetPopularMoviesUseCase(repo);
    _cubit = PopularCubit(useCase);
    _cubit.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PopularCubit, PopularState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is PopularLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PopularSuccess) {
            return Center(
              child: ListView.builder(
                itemCount: _cubit.popularMovies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_cubit.popularMovies[index].title),
                  );
                },
              ),
            );
          } else if (state is PopularError) {
            return Center(child: Text("Error State"));
          }
          return SizedBox();
        },
      ),
    );
  }
}

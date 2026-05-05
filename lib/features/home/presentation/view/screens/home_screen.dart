import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_constant.dart';
import 'package:movie_app/core/widgets/app_cached_image.dart';
import 'package:movie_app/features/home/data/repo/repository/home_repository_imp.dart';
import 'package:movie_app/features/home/domain/use_case/get_popular_movies_use_case.dart';
import 'package:movie_app/features/home/domain/use_case/get_top_rated_movies_use_case.dart';
import 'package:movie_app/features/home/presentation/view/widgets/title_section_widget.dart';
import 'package:movie_app/features/home/presentation/view_model/home_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  late HomeCubit _cubit;
  void initState() {
    super.initState();
    var useCase1 = GetPopularMoviesUseCase(homeRepositoryInjectable());
    var useCase2 = GetTopRatedMoviesUseCase(homeRepositoryInjectable());
    _cubit = HomeCubit(
      getPopularMoviesUseCase: useCase1,
      getTopRatedMoviesUseCase: useCase2,
    );
    _cubit.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is Success) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TitleSectionWidget(title: 'Top Rated'),
                    SizedBox(
                      height: 250,

                      child: ListView.builder(
                        itemCount: state.topRatedMovies.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () {},
                              child: AppCachedImage(
                                imageUrl: ApiConstants.getFullImageUrl(
                                  state.topRatedMovies[index].posterPath,
                                ),
                                height: 210,
                                width: 140,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 40),
                    TitleSectionWidget(title: 'Popular'),
                    SizedBox(
                      height: 440,
                      width: .infinity,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 13,
                          crossAxisSpacing: 8,
                          childAspectRatio: 145 / 100,
                        ),
                        itemBuilder: (context, index) {
                          return AppCachedImage(
                            imageUrl: ApiConstants.getFullImageUrl(
                              state.popularMovies[index].posterPath,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          );
                        },
                        itemCount: state.popularMovies.length,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is Error) {
              return Center(child: Text(state.errorMessage));
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

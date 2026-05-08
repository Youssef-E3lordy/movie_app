import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_constant.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/widgets/app_cached_image.dart';
import 'package:movie_app/features/home/domain/use_case/get_popular_movies_use_case.dart';
import 'package:movie_app/features/home/domain/use_case/get_release_movies_use_case.dart';
import 'package:movie_app/features/home/domain/use_case/get_top_rated_movies_use_case.dart';
import 'package:movie_app/features/home/presentation/view/widgets/skeletonizer_widget.dart';
import 'package:movie_app/features/home/presentation/view/widgets/title_section_widget.dart';
import 'package:movie_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:movie_app/features/details/presentation/view/screens/details_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';
// import 'details/presentation/view/screens/details_screen.dart'

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
    _cubit = HomeCubit(
      getPopularMoviesUseCase: getPopularMoviesUseCaseInjectable(),
      getTopRatedMoviesUseCase: getTopRatedMoviesUseCaseInjectable(),
      getReleaseMoviesUseCase: getReleaseMoviesUseCaseInjectable(),
    );
    _cubit.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state is Loading) {
              return SkeletonizerWidget();
            } else if (state is Success) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TitleSectionWidget(title: 'Top Rated'),
                    SizedBox(
                      height: 250,

                      child: ListView.builder(
                        itemCount: state.topRatedMovies.length > 10
                            ? 10
                            : state.topRatedMovies.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 8),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      movieId: state.topRatedMovies[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: 250,
                                width: 180,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: AppCachedImage(
                                        imageUrl: ApiConstants.getFullImageUrl(
                                          state
                                              .topRatedMovies[index]
                                              .posterPath,
                                        ),
                                        height: 240,
                                        width: 150,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),

                                    Positioned(
                                      left: 0,
                                      bottom: -40,
                                      child: Stack(
                                        children: [
                                          Text(
                                            '${index + 1}',
                                            style: TextStyle(
                                              fontSize: 110,
                                              fontWeight: FontWeight.w900,
                                              color: AppColors.background,
                                            ),
                                          ),

                                          Text(
                                            '${index + 1}',
                                            style: TextStyle(
                                              fontSize: 110,
                                              fontWeight: FontWeight.w900,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 1
                                                ..color = AppColors.outLineText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 40),
                    TitleSectionWidget(title: 'Release'),
                    SizedBox(
                      height: 250,

                      child: ListView.builder(
                        itemCount: state.releaseRatedMovies.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 8),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      movieId:
                                          state.releaseRatedMovies[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: index == 0 ? 8 : 0,
                                ), // Add left padding to the first item
                                child: AppCachedImage(
                                  imageUrl: ApiConstants.getFullImageUrl(
                                    state.releaseRatedMovies[index].posterPath,
                                  ),
                                  height: 240,
                                  width: 145,
                                  borderRadius: BorderRadius.circular(16),
                                ),
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
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    movieId: state.popularMovies[index].id,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 8 : 0,
                              ),
                              child: AppCachedImage(
                                imageUrl: ApiConstants.getFullImageUrl(
                                  state.popularMovies[index].posterPath,
                                ),
                                height: 240,
                                width: 145,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/utils/app_assets.dart';

import 'package:movie_app/core/widgets/custom_app_bar.dart';
import 'package:movie_app/features/details/domin/use_case/movie_details_use_case.dart';
import 'package:movie_app/features/details/domin/use_case/similar_movies_use_case.dart';
import 'package:movie_app/features/details/presentation/view/widgets/back_drop_widget.dart';
import 'package:movie_app/features/details/presentation/view/widgets/poster_widget.dart';
import 'package:movie_app/features/details/presentation/view/widgets/tag_widgets.dart';
import 'package:movie_app/features/details/presentation/view_model/details_cubit.dart';
import 'package:movie_app/features/details/presentation/view_model/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  final int movieId;
  const DetailsScreen({super.key, required this.movieId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final DetailsCubit _detailsCubit;
  late final SimilarMoviesCubit _similarCubit;

  @override
  void initState() {
    super.initState();

    _detailsCubit = DetailsCubit(getMovieDetailsUseCaseInjector());

    _similarCubit = SimilarMoviesCubit(getSimilarMoviesUseCaseInjector());

    _detailsCubit.fetchMovieDetails(widget.movieId);
    _similarCubit.fetchSimilarMovies(widget.movieId);
  }

  bool isBookMarked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detail',
        showBackButton: true,
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              isBookMarked ? AppAssets.yellowBookMark : AppAssets.bookMark,
            ),
            onPressed: () {
              setState(() {
                isBookMarked = !isBookMarked;
              });
            },
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _detailsCubit),
          BlocProvider.value(value: _similarCubit),
        ],
      child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        BlocBuilder<DetailsCubit, MovieDetailsState>(
                          builder: (context, state) {
                            if (state is MovieDetailsLoadingState) {
                              return const Center(child: CircularProgressIndicator());
                            }
                        
                            if (state is MovieDetailsErrorState) {
                              return Text(state.error);
                            }
                        
                            if (state is MovieDetailsSuccessState) {
                              final data = state.data;
                        
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      const SizedBox(height: 320),
                                      BackDropWidget(
                                        backdropPath: data.backdropPath,
                                        rateValue: data.voteAverage,
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        left: 15,
                                        child: CustomPosterWidget(
                                          posterUrl:
                                              "https://image.tmdb.org/t/p/w500${data.posterPath}",
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 120,
                                        child: Text(
                                          data.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                        
                                  Center(
                                    child: TagWidgets(
                                      runtime: data.runtime.toString(),
                                      releaseDate: data.releaseDate.split("-").first,
                                      genresName: data.genres.join(", ").split( ",").first,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(data.overview),
                                  ),
                                ],
                              );
                            }
                        
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<SimilarMoviesCubit, SimilarMoviesState>(
                          builder: (context, state) {
                            if (state is SimilarMoviesLoadingState) {
                              return const Center(child: CircularProgressIndicator());
                            }
                    
                            if (state is SimilarMoviesErrorState) {
                              return Text(state.error);
                            }
                    
                            if (state is SimilarMoviesSuccessState) {
                              final movies = state.data;
                    
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(10),
                                itemCount: movies.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.6,
                                    ),
                                itemBuilder: (context, index) {
                                  final movie = movies[index];
                                                  
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              DetailsScreen(movieId: movie.id),
                                        ),
                                      );
                                    },
                                    child: CustomPosterWidget(
                                      posterUrl:
                                          "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                    ),
                                  );
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              )
      )
      );
      
    }
  }

  


         
  








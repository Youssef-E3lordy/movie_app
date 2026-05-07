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
import 'package:skeletonizer/skeletonizer.dart';

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
              delegate: SliverChildListDelegate([
                BlocBuilder<DetailsCubit, MovieDetailsState>(
                  builder: (context, state) {
                    final isLoading = state is MovieDetailsLoadingState;
                    final data = state is MovieDetailsSuccessState
                        ? state.data
                        : null;
                    return Skeletonizer(
                      enabled: isLoading,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              const SizedBox(height: 320),
                              BackDropWidget(
                                backdropPath: data?.backdropPath ?? "",
                                rateValue: data?.voteAverage ?? 0,
                              ),
                              Positioned(
                                bottom: 25,
                                left: 15,
                                child: CustomPosterWidget(
                                  posterUrl: data?.posterPath ?? "",
                                ),
                              ),

                              Positioned(
                                bottom: 40,
                                left: 120,
                                child: Text(
                                  data?.title ?? "Loading title...",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Center(
                              child: TagWidgets(
                                runtime: data?.runtime.toString() ?? "120",
                                releaseDate:
                                    data?.releaseDate.split("-").first ??
                                    "2024",
                                genresName: data?.genres.join(", ") ?? "Action",
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data?.overview ??
                                  "Loading overview loading overview loading overview...",
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: 20),
                BlocBuilder<SimilarMoviesCubit, SimilarMoviesState>(
                  builder: (context, state) {
                    final isLoading = state is SimilarMoviesLoadingState;

                    final movies = state is SimilarMoviesSuccessState
                        ? state.data
                        : List.generate(6, (_) => null);

                    return Skeletonizer(
                      enabled: isLoading,
                      child: GridView.builder(
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
                              if (movie != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsScreen(movieId: movie.id),
                                  ),
                                );
                              }
                            },
                            child: CustomPosterWidget(
                              posterUrl: movie?.posterPath ?? "",
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

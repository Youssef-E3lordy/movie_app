import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/widgets/empty_state.dart';
import 'package:movie_app/features/details/presentation/view/screens/details_screen.dart';
import 'package:movie_app/features/search/domain/entites/search_entity.dart';
import 'package:movie_app/features/search/presentation/view/widget/movie_card_search_widget.dart';
import 'package:movie_app/features/search/presentation/view/widget/search_text_field.dart';
import 'package:movie_app/features/search/presentation/view_model/search_cubit.dart';
import 'package:movie_app/features/search/presentation/view_model/search_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<SearchCubit>(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Search", style: TextStyle(color: AppColors.textPrimary)),
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  return TextFormFeildWidget(
                    controller: search,
                    hintText: "Search",
                    suffixIcon: Icons.search,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter search text";
                      }
                      return null;
                    },
                    onPressed: () {
                      if (search.text.trim().isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        context.read<SearchCubit>().searchMovie(search.text);
                      }
                    },
                    onFieldSubmitted: (value) {
                      context.read<SearchCubit>().searchMovie(value);
                    },
                  );
                },
              ),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Skeletonizer(
                            enabled: true,
                            child: MoviesCard(
                              movie: MovieEntity(
                                title: "Loading title",
                                posterPath: "",
                                voteAverage: 0,
                                genreIds: [],
                                releaseDate: "",
                                adult: false,
                              ),
                            ),
                          );
                        },
                      );
                    }
                    if (state is ErrorState) {
                      return Center(child: Text(state.errorMessage));
                    }
                    if (state is SuccessState) {
                      if (state.movies.isEmpty) {
                        return EmptyStateWidget(
                          message: "we are sorry, we can not find the movie :(",
                          supMassage:
                              "Find your movie by Type title, categories, years, etc .",
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    movieId: state.movies[index].id,
                                  ),
                                ),
                              );
                            },
                            child: MoviesCard(movie: state.movies[index]),
                          );
                        },
                        itemCount: state.movies.length,
                      );
                    }
                    return Center(child: Text("Start searching 🔍"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
}

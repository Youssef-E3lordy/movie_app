import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/widgets/custom_app_bar.dart';
import 'package:movie_app/core/widgets/empty_state.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/repo/watchlist_repository.dart';
import '../view_model/watchlist_cubit.dart';
import '../view_model/watchlist_state.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WatchlistCubit(WatchlistRepository())..loadWatchlist(),
      child: Scaffold(
        appBar: CustomAppBar(title: "Watch list",centerTitle: true,showBackButton: false,),
        body: BlocBuilder<WatchlistCubit, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WatchlistError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (state is WatchlistSuccess) {
              if (state.movies.isEmpty) {
                return const EmptyStateWidget(
                  message: "There is no movie yet!",
                  supMassage:
                      "Find your movie by Type title, categories, years, etc ",
                      imagePath: AppAssets.imgFolder,
                );
              }
              return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return ListTile(
                    title: Text(
                      movie.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.bookmark,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        context.read<WatchlistCubit>().toggleWatchlist(movie);
                      },
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

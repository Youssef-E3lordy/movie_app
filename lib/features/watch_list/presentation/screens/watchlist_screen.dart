import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/widgets/app_cached_image.dart';
import 'package:movie_app/core/widgets/custom_app_bar.dart';
import 'package:movie_app/core/widgets/empty_state.dart';
import 'package:movie_app/features/watch_list/presentation/view_model/watchlist_cubit.dart';
import 'package:movie_app/features/watch_list/presentation/view_model/watchlist_state.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Watch list',
        showBackButton: false,
        centerTitle: true,
      ),
      body: BlocBuilder<WatchlistCubit, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WatchlistError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.darkWhite),
              ),
            );
          } else if (state is WatchlistSuccess) {
            if (state.movies.isEmpty) {
              return const EmptyStateWidget(
                message: 'There is no movie yet!',
                supMassage: 'Find your movie by Type title, categories, years, etc',
                imagePath: AppAssets.imgFolder,
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                
                return Dismissible(
                  key: Key(movie.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<WatchlistCubit>().toggleWatchlist(movie);
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.delete_outline, color: AppColors.textPrimary, size: 30),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppCachedImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          width: 105,
                          height: 155,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                              _buildInfoRow(AppAssets.star, '9.5', isRating: true),
                              const SizedBox(height: 6),
                              _buildInfoRow(AppAssets.ticket, 'Action'),
                              const SizedBox(height: 6),
                              _buildInfoRow(AppAssets.calendarBlank, '2019'),
                              const SizedBox(height: 6),
                              _buildInfoRow(AppAssets.clock, '139 minutes'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildInfoRow(String iconPath, String text, {bool isRating = false}) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(
            isRating ? AppColors.star : AppColors.textSecondary, 
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: isRating ? AppColors.star : AppColors.textSecondary,
            fontSize: 14,
            fontWeight: isRating ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
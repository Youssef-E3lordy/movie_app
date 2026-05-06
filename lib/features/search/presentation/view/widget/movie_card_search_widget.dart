import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/network/api_constant.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/widgets/app_cached_image.dart';
import 'package:movie_app/features/search/domain/entites/search_entity.dart';

class MoviesCard extends StatelessWidget {
  const MoviesCard({super.key, required this.movie});
  final MovieEntity movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          AppCachedImage(
            imageUrl: ApiConstants.getFullImageUrl(movie.posterPath),
            borderRadius: BorderRadius.circular(10),
            fit: BoxFit.cover,
            height: 120,
            width: 95,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.whiteGray, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.star,
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        AppColors.accent,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${movie.voteAverage}",
                      style: TextStyle(color: AppColors.accent),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.ticket,
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        AppColors.darkWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      movie.genreNames,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColors.darkWhite),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.calendarBlank,
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        AppColors.darkWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      movie.releaseDate,
                      style: TextStyle(color: AppColors.darkWhite),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.clock,
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        AppColors.darkWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      ApiConstants.getMovieDetails(movie.id),
                      style: TextStyle(color: AppColors.darkWhite),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

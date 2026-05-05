import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/network/api_constant.dart';

import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';


class BackDropWidget extends StatelessWidget {
  final String backdropPath;
  final double rateValue;

  const BackDropWidget({
    super.key,
    required this.backdropPath,
    required this.rateValue,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .bottomRight,
      children: [
        SizedBox(
      
          width: .infinity,
          child: CachedNetworkImage(
            imageUrl: ApiConstants.getFullImageUrl(backdropPath),
            fit: .cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),

        Padding(
          padding: .only(right: 15, bottom: 10),
          child: ClipRRect(
            borderRadius: .circular(8),
            child: Container(
              padding: .symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: .circular(10),
              ),
              child: Row(
                mainAxisSize: .min,
                children: [
                  SvgPicture.asset(AppAssets.star),
                  SizedBox(width: 5),
                  Text(
                    rateValue.toStringAsFixed(1),
                    style: const TextStyle(
                      color: AppColors.star,
                      fontWeight: .bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
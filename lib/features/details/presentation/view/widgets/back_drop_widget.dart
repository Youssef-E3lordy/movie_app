import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/network/api_constant.dart';

import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import '/core/widgets/app_cached_image.dart';

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
   if (backdropPath.isEmpty) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }


  return Stack(
    alignment: Alignment.bottomRight,
    children: [
      SizedBox(
        width: double.infinity,
        height: 200,
        child: AppCachedImage(
          imageUrl: ApiConstants.getFullImageUrl(backdropPath),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(right: 15, bottom: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppAssets.star),
                const SizedBox(width: 5),
                Text(
                  rateValue.toStringAsFixed(1),
                  style: const TextStyle(
                    color: AppColors.star,
                    fontWeight: FontWeight.bold,
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

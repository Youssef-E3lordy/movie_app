import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:movie_app/core/network/api_constant.dart';

class CustomPosterWidget extends StatelessWidget {
  const CustomPosterWidget({super.key, required this.posterUrl});
  final String posterUrl;

  @override
  Widget build(BuildContext context) {
    if (posterUrl.isEmpty) {
    return Container(
      width: 95,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  return CachedNetworkImage(
    imageUrl: ApiConstants.getFullImageUrl(posterUrl),
    imageBuilder: (context, imageProvider) => Container(
      width: 95,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
  }

  
  }

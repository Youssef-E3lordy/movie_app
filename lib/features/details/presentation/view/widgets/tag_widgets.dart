import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/utils/app_assets.dart';

class TagWidgets extends StatelessWidget {
  final String runtime;
  final String releaseDate;
  final String genresName;
  const TagWidgets({super.key, required this.runtime, required this.releaseDate, required this.genresName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
       
        children: [
          SvgPicture.asset(AppAssets.calendarBlank),
          Text(" $releaseDate |"),

          const SizedBox(width: 4),
         
          SvgPicture.asset(AppAssets.clock),
          Text(" $runtime  Minutes |"),
          const SizedBox(width: 4),

          SvgPicture.asset(AppAssets.ticket),
          Text(" $genresName "),
        ],
      ),
    );
  }
}

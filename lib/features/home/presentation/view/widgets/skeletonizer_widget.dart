import 'package:flutter/material.dart';
import 'package:movie_app/core/widgets/app_cached_image.dart';
import 'package:movie_app/features/home/presentation/view/widgets/title_section_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonizerWidget extends StatelessWidget {
  const SkeletonizerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,

      child: SingleChildScrollView(
        child: Column(
          children: [
            TitleSectionWidget(title: 'Release'),
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(right: 8),
                  child: AppCachedImage(
                    imageUrl: '',
                    height: 210,
                    width: 140,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 40),
            TitleSectionWidget(title: 'Top Rated'),
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(right: 8),
                  child: AppCachedImage(
                    imageUrl: '',
                    height: 210,
                    width: 140,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 40),
            TitleSectionWidget(title: 'Popular'),
            SizedBox(
              height: 440,
              width: .infinity,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 13,
                  crossAxisSpacing: 8,
                  childAspectRatio: 145 / 100,
                ),
                itemBuilder: (context, index) => AppCachedImage(
                  imageUrl: '',
                  borderRadius: BorderRadius.circular(16),
                ),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? leading;
  final bool? centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.leading,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      leading: showBackButton
          ? leading ??
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.darkWhite),
                  onPressed: () => Navigator.of(context).pop(),
                )
          : null,
      title: Text(title,style: TextStyle(color: AppColors.darkWhite),),
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

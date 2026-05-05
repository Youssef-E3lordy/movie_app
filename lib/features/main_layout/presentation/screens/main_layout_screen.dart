import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/features/search/presentation/view/screens/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() {
    return const [
      Center(
        child: Text('Home Screen', style: TextStyle(color: Colors.white)),
      ),
      SearchScreen(),
      Center(
        child: Text('Watchlist Screen', style: TextStyle(color: Colors.white)),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.iconHome,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.primary,
            BlendMode.srcIn,
          ),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.iconHome,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
        ),
        title: "Home",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.iconSearch,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.primary,
            BlendMode.srcIn,
          ),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.iconSearch,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
        ),
        title: "Search",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.iconBookmark,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.primary,
            BlendMode.srcIn,
          ),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.iconBookmark,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
        ),
        title: "Watch list",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineToSafeArea: true,
      backgroundColor: AppColors.background,
      stateManagement: true,
      decoration: const NavBarDecoration(
        border: Border(top: BorderSide(color: AppColors.primary, width: 1.5)),
      ),
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}

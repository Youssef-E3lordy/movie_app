import 'package:flutter/material.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'features/main_layout/presentation/screens/main_layout_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',

      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
        ),
      ),
      home: Scaffold(body: MainLayoutScreen()),
    );
  }
}

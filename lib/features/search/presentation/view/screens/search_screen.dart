import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/features/search/presentation/view/widget/search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController? search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Search", style: TextStyle(color: AppColors.textPrimary)),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            TextFormFeildWidget(
              controller: search,
              hintText: "Search",
              suffixIcon: Icons.search,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter search text";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

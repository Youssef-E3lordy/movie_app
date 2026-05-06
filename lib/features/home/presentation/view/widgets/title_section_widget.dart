import 'package:flutter/widgets.dart';

class TitleSectionWidget extends StatelessWidget {
  const TitleSectionWidget({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 48,
        width: 110,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

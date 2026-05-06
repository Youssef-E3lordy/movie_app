import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';

// ignore: must_be_immutable
class TextFormFeildWidget extends StatefulWidget {
  TextFormFeildWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.suffixIcon,
    required this.onPressed,
    required this.onFieldSubmitted,
  });
  IconData? suffixIcon;
  void Function() onPressed;
  final Function(String) onFieldSubmitted;

  TextEditingController? controller;

  String? hintText;

  String? Function(String?)? validator;

  @override
  State<TextFormFeildWidget> createState() => _TextFormFeildState();
}

class _TextFormFeildState extends State<TextFormFeildWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                onPressed: widget.onPressed,
                icon: Icon(Icons.search, color: AppColors.surface),
              )
            : null,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColors.darkWhite),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.surface),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        contentPadding: EdgeInsets.all(15),
      ),
      validator: widget.validator,
    );
  }
}

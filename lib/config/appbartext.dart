import 'package:final_year_project_1_2/config/palette.dart';
import 'package:flutter/material.dart';

class AppBarText extends StatelessWidget {
  const AppBarText({@required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Palette.cobalt,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    );
  }
}
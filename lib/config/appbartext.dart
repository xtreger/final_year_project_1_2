import 'package:flutter/material.dart';

class AppBarText extends StatelessWidget {
  const AppBarText({@required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    );
  }
}
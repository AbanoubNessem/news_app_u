import 'package:flutter/material.dart';
import 'package:news_app/utility/app_colores.dart';

class MyAppBar extends StatelessWidget {
  Color color;
  String title;
  Color titleColor;
  Color iconColor;
  MyAppBar({super.key,required this.title, required this.titleColor,required this.color,required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      centerTitle: true,
      title: Text(title,
        style: TextStyle(
            color: titleColor,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
      elevation: 0.0,
      iconTheme:  IconThemeData(
          color: iconColor
      ),
    );
  }
}

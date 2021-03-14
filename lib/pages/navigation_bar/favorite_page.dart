import 'package:ala_kosan/shared/themes.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Favorite Page",
          style: contentTitle2(context),
        ),
      ),
    );
  }
}

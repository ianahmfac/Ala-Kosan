import 'package:ala_kosan/shared/themes.dart';
import 'package:flutter/material.dart';

class BookedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Booked Page",
          style: contentTitle2(context),
        ),
      ),
    );
  }
}

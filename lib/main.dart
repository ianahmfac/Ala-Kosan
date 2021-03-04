import 'package:ala_kosan/pages.dart/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ala Kosan',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        accentColor: Colors.yellowAccent,
        scaffoldBackgroundColor: Color(0xffe5e5e5),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
        ),
      ),
      home: Wrapper(),
    );
  }
}

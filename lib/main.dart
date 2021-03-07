import 'package:ala_kosan/pages.dart/signup_page.dart';
import 'package:ala_kosan/pages.dart/wrapper.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ala Kosan',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: accentColor,
          scaffoldBackgroundColor: backgroundColor,
          elevatedButtonTheme: elevatedButtonStyle,
          outlinedButtonTheme: outlineButtonStyle,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: Wrapper(),
        routes: {
          SignUpPage.routeName: (ctx) => SignUpPage(),
        },
      ),
    );
  }
}

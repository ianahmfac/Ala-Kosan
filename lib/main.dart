import 'package:ala_kosan/pages/auth/image_pick_page.dart';
import 'package:ala_kosan/pages/auth/signup_page.dart';
import 'package:ala_kosan/pages/wrapper.dart';
import 'package:ala_kosan/providers/user_provider.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: GestureDetector(
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
            ImagePickPage.routeName: (ctx) => ImagePickPage(),
          },
        ),
      ),
    );
  }
}

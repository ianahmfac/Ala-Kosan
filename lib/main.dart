import 'package:ala_kosan/pages/auth/image_pick_page.dart';
import 'package:ala_kosan/pages/auth/signup_page.dart';
import 'package:ala_kosan/pages/city_list_kos.dart';
import 'package:ala_kosan/pages/detail_kos.dart';
import 'package:ala_kosan/pages/list_kos.dart';
import 'package:ala_kosan/pages/payment/order_summary.dart';
import 'package:ala_kosan/pages/payment/pin_input_page.dart';
import 'package:ala_kosan/pages/wrapper.dart';
import 'package:ala_kosan/providers/city_provider.dart';
import 'package:ala_kosan/providers/kosan_provider.dart';
import 'package:ala_kosan/providers/user_provider.dart';
import 'package:ala_kosan/services/auth_service.dart';
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return StreamProvider.value(
      value: AuthService.userSignIn,
      initialData: null,
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => CityProvider()),
          ChangeNotifierProvider(create: (context) => KosanProvider()),
        ],
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus.unfocus(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ala Kosan',
            theme: ThemeData(
              primarySwatch: Colors.red,
              primaryColor: primaryColor,
              accentColor: accentColor,
              elevatedButtonTheme: elevatedButtonStyle,
              outlinedButtonTheme: outlineButtonStyle,
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
            home: Wrapper(),
            routes: {
              SignUpPage.routeName: (ctx) => SignUpPage(),
              ImagePickPage.routeName: (ctx) => ImagePickPage(),
              DetailKos.routeName: (ctx) => DetailKos(),
              ListKos.routeName: (ctx) => ListKos(),
              CityListKos.routeName: (ctx) => CityListKos(),
              OrderSummary.routeName: (ctx) => OrderSummary(),
              PinInputPage.routeName: (ctx) => PinInputPage(),
            },
          ),
        ),
      ),
    );
  }
}

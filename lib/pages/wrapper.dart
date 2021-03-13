import 'package:ala_kosan/pages/home_page.dart';
import 'package:ala_kosan/pages/auth/login_page.dart';
import 'package:ala_kosan/pages/onboard_screen.dart';
import 'package:ala_kosan/services/auth_service.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatelessWidget {
  Future<bool> _isFirst() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isFirst = pref.getBool("isFirst") ?? true;
    return isFirst;
  }

  final Widget _loading = Scaffold(
    body: Center(
      child: SpinKitFadingCircle(
        color: accentColor,
        size: 50,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isFirst(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data
              ? OnboardScreen()
              : StreamBuilder<User>(
                  stream: AuthService.userSignIn,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return HomePage();
                    }
                    return LoginPage();
                  },
                );
        }
        return _loading;
      },
    );
  }
}

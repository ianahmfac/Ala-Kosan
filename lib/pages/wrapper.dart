import 'package:ala_kosan/pages/login_page.dart';
import 'package:ala_kosan/pages/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatelessWidget {
  Future<bool> _isFirst() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isFirst = pref.getBool("isFirst") ?? true;
    return isFirst;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isFirst(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data ? OnboardScreen() : LoginPage();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

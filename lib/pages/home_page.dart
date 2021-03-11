import 'package:ala_kosan/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sign In"),
          ElevatedButton(
            onPressed: () => AuthService.signOut(),
            child: Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}

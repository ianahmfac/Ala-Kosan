import 'package:ala_kosan/providers/user_provider.dart';
import 'package:ala_kosan/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<UserProvider>(
            builder: (context, value, child) => Text(
              "Sign In as ${value.user != null ? value.user.name : "Loading"}",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).userSignOut();
              AuthService.signOut();
            },
            child: Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}

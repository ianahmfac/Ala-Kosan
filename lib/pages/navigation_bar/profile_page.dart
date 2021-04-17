import 'package:ala_kosan/providers/user_provider.dart';
import 'package:ala_kosan/services/auth_service.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/city_provider.dart';
import '../../providers/kosan_provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Profile Page",
              style: contentTitle2(context),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<UserProvider>().userSignOut();
                context.read<KosanProvider>().userSignOut();
                context.read<CityProvider>().userSignOut();
                AuthService.signOut();
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}

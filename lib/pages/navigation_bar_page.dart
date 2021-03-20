import 'package:ala_kosan/pages/navigation_bar/booked_page.dart';
import 'package:ala_kosan/pages/navigation_bar/favorite_page.dart';
import 'package:ala_kosan/pages/navigation_bar/home_page.dart';
import 'package:ala_kosan/pages/navigation_bar/profile_page.dart';
import 'package:ala_kosan/providers/city_provider.dart';
import 'package:ala_kosan/providers/kosan_provider.dart';
import 'package:ala_kosan/providers/user_provider.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class NavigationBarPage extends StatefulWidget {
  @override
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0;
  List<Widget> _pages = [
    HomePage(),
    BookedPage(),
    FavoritePage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    Provider.of<UserProvider>(context, listen: false).getCurrentUser();
    Provider.of<CityProvider>(context, listen: false).getCities();
    Provider.of<KosanProvider>(context, listen: false).getKosan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.3))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GNav(
              rippleColor: primaryColor.withOpacity(0.5),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              selectedIndex: _selectedIndex,
              onTabChange: (index) => setState(() => _selectedIndex = index),
              activeColor: primaryColor.withOpacity(0.5),
              backgroundColor: Colors.white,
              curve: Curves.easeOutExpo,
              tabBackgroundColor: primaryColor.withOpacity(0.1),
              gap: 4,
              tabs: [
                GButton(
                  icon: (_selectedIndex == 0)
                      ? EvaIcons.home
                      : EvaIcons.homeOutline,
                  text: "Home",
                ),
                GButton(
                  icon: (_selectedIndex == 1)
                      ? EvaIcons.bookOpen
                      : EvaIcons.bookOpenOutline,
                  text: "Booked",
                ),
                GButton(
                  icon: (_selectedIndex == 2)
                      ? EvaIcons.heart
                      : EvaIcons.heartOutline,
                  text: "Favorite",
                ),
                GButton(
                  icon: (_selectedIndex == 3)
                      ? EvaIcons.person
                      : EvaIcons.personOutline,
                  text: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

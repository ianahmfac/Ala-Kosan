import 'package:ala_kosan/models/user_app.dart';
import 'package:ala_kosan/pages/list_kos.dart';
import 'package:ala_kosan/providers/city_provider.dart';
import 'package:ala_kosan/providers/kosan_provider.dart';
import 'package:ala_kosan/providers/user_provider.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/widgets/city_item.dart';
import 'package:ala_kosan/widgets/kosan_item.dart';
import 'package:ala_kosan/widgets/shimmer_loading/city_loading.dart';
import 'package:ala_kosan/widgets/shimmer_loading/kosan_loading.dart';
import 'package:ala_kosan/widgets/user_circle_avatar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        elevation: 0,
        flexibleSpace: _buildHelloUser(user),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(user, context),
            SizedBox(height: 16),
            _buildTitleSection(context, "Yuk, Cari di Kota Ini!", () {}, false),
            SizedBox(height: 8),
            _buildCityCard(),
            SizedBox(height: 16),
            _buildTitleSection(context, "Rekomendasi Untukmu!", () {
              Navigator.of(context).pushNamed(ListKos.routeName);
            }),
            SizedBox(height: 8),
            _listOfKosan(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _listOfKosan() => Consumer<KosanProvider>(
        builder: (context, kosanProvider, child) {
          final kosan = kosanProvider.listOfKosanHome;
          return kosan.isNotEmpty
              ? Column(
                  children: List.generate(
                    kosan.length,
                    (index) {
                      final kosanItem = kosan[index];
                      return KosanItem(kosanItem: kosanItem);
                    },
                  ),
                )
              : Column(
                  children: List.generate(
                    2,
                    (index) => KosanLoading(),
                  ),
                );
        },
      );

  Widget _buildTitleSection(
      BuildContext context, String title, Function function,
      [bool hasButton = true]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: contentTitle(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (hasButton)
            TextButton(
              onPressed: function,
              child: Text("See All"),
              style: TextButton.styleFrom(
                primary: primaryColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCityCard() {
    return Consumer<CityProvider>(builder: (context, cityProvider, _) {
      final cities = cityProvider.cities;
      return SizedBox(
        height: 200,
        child: cities.isNotEmpty
            ? ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return CityItem(city: city);
                },
              )
            : CityLoading(),
      );
    });
  }

  Widget _buildHelloUser(UserApp user) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            primaryColor.withOpacity(0.8),
            primaryColor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            user != null
                ? UserCircleAvatar(
                    imageUrl: user.imageUrl,
                    isOnPrimaryColor: true,
                    circleRadius: 10,
                  )
                : SpinKitFadingCircle(
                    color: Colors.white,
                    size: 10,
                  ),
            SizedBox(width: 8),
            Expanded(
                child: Text(
              user != null ? "Hi, ${user.name}" : "Loading user name...",
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(UserApp user, BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        gradient: LinearGradient(
          colors: [
            primaryColor,
            primaryColor.withOpacity(0.8),
            primaryColor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            "Temukan kosan terbaik di sekitarmu",
            style: onBoardTitle(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _buildSearchField(context),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        hintText: "Cari Kosan",
        prefixIcon: Icon(EvaIcons.searchOutline),
      ),
    );
  }
}

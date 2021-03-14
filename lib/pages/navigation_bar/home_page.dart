import 'package:ala_kosan/models/city.dart';
import 'package:ala_kosan/models/user_app.dart';
import 'package:ala_kosan/providers/city_provider.dart';
import 'package:ala_kosan/providers/user_provider.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/widgets/city_item.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  double _scrollPosition;
  bool _isAppBarHasElevation = false;
  Future _cityFuture;

  void _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      _isAppBarHasElevation = _scrollPosition > 150 ? true : false;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _cityFuture = Provider.of<CityProvider>(context, listen: false).getCities();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final cities =
        Provider.of<CityProvider>(context, listen: false).homePageCities;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: _isAppBarHasElevation ? 8 : 0,
        flexibleSpace: (user != null) ? _buildHelloUser(user) : null,
      ),
      body: (user != null)
          ? SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(user, context),
                  SizedBox(height: 16),
                  _buildTitleSection(context, "Yuk, Cari di Kota Ini!", () {}),
                  SizedBox(height: 8),
                  _buildCityCard(cities),
                  SizedBox(height: 16),
                  _buildTitleSection(context, "Rekomendasi Untukmu!", () {}),
                  SizedBox(height: 8),
                  ...List.generate(
                    5,
                    (index) => Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      color: primaryColor,
                      child: Container(
                        height: 70,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: SpinKitFadingCircle(
                color: accentColor,
                size: 50,
              ),
            ),
    );
  }

  Widget _buildTitleSection(
      BuildContext context, String title, Function function) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
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

  Widget _buildCityCard(List<City> cities) {
    return SizedBox(
      height: 150,
      child: FutureBuilder(
        future: _cityFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFadingCircle(
                color: accentColor,
                size: 50,
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final city = cities[index];
              return CityItem(city: city);
            },
          );
        },
      ),
    );
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
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  user.imageUrl != "" ? NetworkImage(user.imageUrl) : null,
              radius: 10,
              child: user.imageUrl != ""
                  ? null
                  : Icon(
                      EvaIcons.person,
                      color: primaryColor,
                      size: 10,
                    ),
            ),
            SizedBox(width: 8),
            Expanded(
                child: Text(
              "Hi, ${user.name ?? ""}",
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
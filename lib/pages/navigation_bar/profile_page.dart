import 'package:ala_kosan/models/user_app.dart';
import 'package:ala_kosan/providers/city_provider.dart';
import 'package:ala_kosan/providers/kosan_provider.dart';
import 'package:ala_kosan/providers/user_provider.dart';
import 'package:ala_kosan/services/auth_service.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/shared/utils.dart';
import 'package:ala_kosan/widgets/user_circle_avatar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: _buildTitleAppBar(context),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<UserProvider>(context, listen: false).getCurrentUser(),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            _buildProfileContainer(user, context),
            _buildContentTitle(context, "Kosan Ku"),
            Column(
              children: [
                _buildListSetting(
                  EvaIcons.creditCardOutline,
                  "Saldo Ku",
                  () {},
                  "(${convertCurrency(user.balance)})",
                ),
                _buildListSetting(
                  EvaIcons.homeOutline,
                  "Kelola Kosan Ku",
                  () {},
                  null,
                ),
              ],
            ),
            _buildContentTitle(context, "About"),
            Column(
              children: [
                _buildListSetting(
                  EvaIcons.smartphoneOutline,
                  "Tentang Aplikasi",
                  () {},
                  null,
                ),
                _buildListSetting(
                  EvaIcons.codeOutline,
                  "Ikuti Developer",
                  () {},
                  null,
                ),
                _buildListSetting(
                  EvaIcons.shareOutline,
                  "Bagikan Ala Kosan",
                  () {},
                  null,
                ),
              ],
            ),
            _buildContentTitle(context, "Authentication"),
            _buildListSetting(
              EvaIcons.logOutOutline,
              "Sign Out",
              () {
                context.read<UserProvider>().userSignOut();
                context.read<KosanProvider>().userSignOut();
                context.read<CityProvider>().userSignOut();
                AuthService.signOut();
              },
              null,
              false,
            ),
            Container(
              height: 32,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentTitle(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Text(
        title,
        style: contentTitle(context).copyWith(
          color: Colors.grey,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildListSetting(
      IconData icon, String title, Function onPressed, String subtitle,
      [bool hasTrail = true]) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: hasTrail
          ? Icon(
              EvaIcons.arrowIosForwardOutline,
              color: Colors.black,
            )
          : null,
      onTap: onPressed,
    );
  }

  Widget _buildProfileContainer(UserApp user, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          UserCircleAvatar(imageUrl: user.imageUrl ?? "", circleRadius: 50),
          SizedBox(height: 8),
          Text(
            user.name,
            style: onBoardTitle(context),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
          SizedBox(height: 2),
          Text(
            user.email,
            style: onBoardSubtitle(context),
          ),
          SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(
              EvaIcons.editOutline,
              size: 20,
            ),
            label: Text("Edit Profile"),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleAppBar(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/images/logo_app.png",
          width: 25,
        ),
        SizedBox(width: 8),
        Text(
          "Ala Kosan",
          style: contentTitle(context).copyWith(color: primaryColor),
        ),
      ],
    );
  }
}

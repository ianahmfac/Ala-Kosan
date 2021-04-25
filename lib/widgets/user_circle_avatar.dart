import 'package:ala_kosan/shared/themes.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class UserCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double circleRadius;
  final bool isOnPrimaryColor;

  const UserCircleAvatar({
    Key key,
    @required this.imageUrl,
    this.circleRadius,
    this.isOnPrimaryColor = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final imageNull = imageUrl == "";
    return CircleAvatar(
      radius: circleRadius ?? null,
      backgroundImage: imageNull ? null : NetworkImage(imageUrl),
      child: imageNull
          ? Icon(
              EvaIcons.person,
              color: isOnPrimaryColor ? primaryColor : Colors.white,
              size: circleRadius ?? null,
            )
          : null,
      backgroundColor: isOnPrimaryColor ? Colors.white : primaryColor,
    );
  }
}

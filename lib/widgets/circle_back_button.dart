import 'dart:io';

import 'package:ala_kosan/shared/themes.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class CircleBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: primaryColor.withOpacity(0.5),
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: SizedBox(
            height: 40,
            width: 40,
            child: Icon(
              Platform.isAndroid
                  ? EvaIcons.arrowBackOutline
                  : EvaIcons.arrowIosBackOutline,
            ),
          ),
        ),
      ),
    );
  }
}

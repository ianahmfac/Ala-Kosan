import 'package:ala_kosan/shared/themes.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eva_icons_flutter/icon_data.dart';
import 'package:flutter/material.dart';

class ChipType extends StatelessWidget {
  final String text;
  final EvaIconData icon;

  ChipType({Key key, @required this.text, this.icon = EvaIcons.person})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = (text.toLowerCase() == "campur")
        ? Colors.green
        : (text.toLowerCase() == "pria")
            ? Colors.blue
            : (text.toLowerCase() == "wanita")
                ? Colors.pink
                : text.contains(RegExp("^[0-9]"))
                    ? accentColor
                    : primaryColor;
    return Chip(
      backgroundColor: color.withOpacity(0.1),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          SizedBox(width: 4),
          Text(text, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}

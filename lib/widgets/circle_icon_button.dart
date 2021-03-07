import 'package:ala_kosan/shared/themes.dart';
import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
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
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
    );
  }
}

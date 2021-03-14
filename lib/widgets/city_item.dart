import 'package:flutter/material.dart';

import 'package:ala_kosan/models/city.dart';
import 'package:ala_kosan/shared/themes.dart';

class CityItem extends StatelessWidget {
  final City city;
  const CityItem({
    Key key,
    @required this.city,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor,
      margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FadeInImage(
          image: NetworkImage(city.image),
          placeholder: AssetImage("assets/images/placeholder.png"),
          height: 150,
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

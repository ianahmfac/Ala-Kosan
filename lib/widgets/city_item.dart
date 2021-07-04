import 'package:ala_kosan/models/city.dart';
import 'package:ala_kosan/pages/city_list_kos.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CityItem extends StatelessWidget {
  final City city;
  const CityItem({
    Key key,
    @required this.city,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: 250,
        child: Card(
          margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(CityListKos.routeName, arguments: city);
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: city.image,
                    height: constraints.maxHeight * 0.7,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => LottieBuilder.asset(
                      "assets/lotties/placeholder.json",
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.3,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(
                        EvaIcons.pin,
                        color: primaryColor,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          city.city,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

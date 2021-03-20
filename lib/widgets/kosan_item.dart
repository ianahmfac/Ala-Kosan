import 'package:ala_kosan/models/city.dart';
import 'package:ala_kosan/models/kosan.dart';
import 'package:ala_kosan/pages/detail_kos.dart';
import 'package:ala_kosan/providers/city_provider.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/shared/utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chip_type.dart';

class KosanItem extends StatelessWidget {
  final Kosan kosanItem;

  const KosanItem({Key key, @required this.kosanItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final City city = Provider.of<CityProvider>(context, listen: false)
        .findCityById(kosanItem.cityId);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          DetailKos.routeName,
          arguments: {
            "id": kosanItem.id,
            "cityName": city.city,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        height: 170,
        width: double.infinity,
        child: Row(
          children: [
            _buildImage(),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kosanItem.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: contentTitle(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Wrap(
                    runSpacing: -8,
                    spacing: 4,
                    children: [
                      ChipType(
                        text: city.city,
                        icon: EvaIcons.pinOutline,
                      ),
                      ChipType(
                        text: kosanItem.rating.toString(),
                        icon: EvaIcons.star,
                      ),
                      ChipType(text: kosanItem.type),
                    ],
                  ),
                  Spacer(),
                  RichText(
                    text: TextSpan(
                      text: convertCurrency(kosanItem.price),
                      style: contentBody(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: " / bulan",
                          style:
                              onBoardSubtitle(context).copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Hero(
            tag: kosanItem.id,
            child: FadeInImage(
              placeholder: AssetImage("assets/images/placeholder.png"),
              image: NetworkImage(kosanItem.images[0]),
              fit: BoxFit.cover,
              height: double.infinity,
              width: 120,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Material(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                splashColor: accentColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    EvaIcons.heartOutline,
                    color: accentColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

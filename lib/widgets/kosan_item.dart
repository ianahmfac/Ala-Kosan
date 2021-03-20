import 'package:ala_kosan/models/city.dart';
import 'package:ala_kosan/models/kosan.dart';
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
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        height: 170,
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage(
                placeholder: AssetImage("assets/images/placeholder.png"),
                image: NetworkImage(kosanItem.images[0]),
                fit: BoxFit.cover,
                height: double.infinity,
                width: 120,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: [
                  Text(
                    kosanItem.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: contentTitle(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        EvaIcons.pinOutline,
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          kosanItem.address,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    convertCurrency(kosanItem.price) + " /bln",
                    style: contentBody(context).copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Wrap(
                    runSpacing: -12,
                    children: [
                      ChipType(text: kosanItem.type),
                      SizedBox(width: 4),
                      ChipType(
                        text: city.city,
                        icon: EvaIcons.pinOutline,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

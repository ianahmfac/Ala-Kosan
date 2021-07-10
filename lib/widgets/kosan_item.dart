import 'package:ala_kosan/models/city.dart';
import 'package:ala_kosan/models/kosan.dart';
import 'package:ala_kosan/pages/detail_kos.dart';
import 'package:ala_kosan/providers/city_provider.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/shared/utils.dart';
import 'package:ala_kosan/widgets/favorite_icon_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'chip_type.dart';

class KosanItem extends StatelessWidget {
  final Kosan kosanItem;

  const KosanItem({Key key, @required this.kosanItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final City city =
        context.read<CityProvider>().findCityById(kosanItem.cityId);
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
          horizontal: 16,
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
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
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
                      text: convertCurrency((kosanItem.price).toDouble()),
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
            child: CachedNetworkImage(
              imageUrl: kosanItem.images[0],
              fit: BoxFit.cover,
              width: 120,
              height: double.infinity,
              placeholder: (context, url) => LottieBuilder.asset(
                "assets/lotties/placeholder.json",
                width: 120,
              ),
            ),
          ),
          Positioned(
            top: -12,
            left: -12,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor,
              ),
              height: 54,
              width: 54,
            ),
          ),
          Positioned(
            top: -8,
            left: -8,
            child: FavoriteIconButton(kosan: kosanItem),
          ),
        ],
      ),
    );
  }
}

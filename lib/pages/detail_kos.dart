import 'dart:io';

import 'package:ala_kosan/helpers/static_map.dart';
import 'package:ala_kosan/models/kosan.dart';
import 'package:ala_kosan/providers/kosan_provider.dart';
import 'package:ala_kosan/shared/device.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/shared/utils.dart';
import 'package:ala_kosan/widgets/chip_type.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailKos extends StatefulWidget {
  static const routeName = "/detail-kos";

  @override
  _DetailKosState createState() => _DetailKosState();
}

class _DetailKosState extends State<DetailKos> {
  String _id;
  String _cityName;
  int _indexImage = 0;
  String _mapUrl;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    init();
  }

  void init() {
    Map<String, Object> arg = ModalRoute.of(context).settings.arguments;
    _id = arg["id"];
    _cityName = arg["cityName"];
  }

  void _launchMap(double latitude, double longitude) async {
    final String maps = Platform.isAndroid
        ? "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude"
        : "comgooglemaps://?saddr=&daddr=$latitude,$longitude&directionsmode=driving";
    final String appleMaps = 'https://maps.apple.com/?q=$latitude,$longitude';

    if (await canLaunch(maps)) {
      await launch(maps);
    } else if (await canLaunch(appleMaps)) {
      await launch(appleMaps);
    } else {
      throw "Tidak dapat membuka Url";
    }
  }

  void _launchWhatsapp(String phoneNumber) async {
    try {
      final url =
          "https://api.whatsapp.com/send/?phone=$phoneNumber&text&app_absent=0";
      if (await canLaunch(url)) {
        await launch(url);
      }
    } catch (e) {
      throw "Tidak dapat membuka WhatsApp";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Kosan kosan =
        Provider.of<KosanProvider>(context, listen: false).findKosanById(_id);
    _mapUrl = Static.generateStaticMap(
        latitude: kosan.latitude, longitude: kosan.longitude);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  flexibleSpace: _buildImageHeader(kosan),
                  expandedHeight: 350 - paddingSafeDevice(context).top,
                ),
                _buildSliverList(kosan, context),
              ],
            ),
          ),
          _buildInfoAndButtonBookNow(kosan, context),
        ],
      ),
    );
  }

  Widget _buildSliverList(Kosan kosan, BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      runSpacing: -8,
                      spacing: 12,
                      children: [
                        ChipType(
                          text: _cityName,
                          icon: EvaIcons.pinOutline,
                        ),
                        ChipType(text: kosan.type),
                      ],
                    ),
                    _buildTitleKosan(kosan, context),
                    SizedBox(height: 8),
                    _buildLocation(kosan, context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleKosan(Kosan kosan, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kosan.name,
                style: contentTitle2(context).copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  ChipType(
                    text: kosan.rating.toString(),
                    icon: EvaIcons.star,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "${kosan.availableRoom} kamar tersedia",
                      style: TextStyle(
                        color:
                            kosan.availableRoom < 3 ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            EvaIcons.messageSquareOutline,
            color: Colors.green,
            size: 32,
          ),
          onPressed: () {
            try {
              _launchWhatsapp(kosan.ownerNumber);
            } catch (e) {
              showSnackbarError(context, e.toString());
            }
          },
        )
      ],
    );
  }

  Widget _buildLocation(Kosan kosan, BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(EvaIcons.pinOutline),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                kosan.address,
                style: onBoardSubtitle(context).copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () {
              showAlert(context,
                  child: CupertinoAlertDialog(
                    title: Text("Ingin membuka MAPS?"),
                    actions: [
                      CupertinoButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: primaryColor),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      CupertinoButton(
                        child: Text("Open Maps"),
                        onPressed: () {
                          try {
                            Navigator.pop(context);
                            _launchMap(kosan.latitude, kosan.longitude);
                          } catch (e) {
                            showSnackbarError(context, e.toString());
                          }
                        },
                      ),
                    ],
                  ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: FadeInImage(
                placeholder: AssetImage("assets/images/placeholder.png"),
                image: NetworkImage(_mapUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoAndButtonBookNow(Kosan kosan, BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: RichText(
                    text: TextSpan(
                      text: convertCurrency(kosan.price),
                      style: contentTitle(context).copyWith(
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
                ),
              ),
              SizedBox(
                height: 50,
                width: widthOfDevice(context) * 0.35,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Book Now"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageHeader(Kosan kosan) {
    return Hero(
      tag: _id,
      child: SizedBox(
        height: 350,
        width: double.infinity,
        child: Stack(
          children: [
            PageView.builder(
              itemCount: kosan.images.length,
              physics: ClampingScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  _indexImage = value;
                });
              },
              itemBuilder: (context, index) => FadeInImage(
                placeholder: AssetImage("assets/images/placeholder.png"),
                image: NetworkImage(kosan.images[_indexImage]),
                fit: BoxFit.cover,
                height: 350,
                width: double.infinity,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor,
                      Colors.transparent
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(kosan.images.length, (index) {
                    return AnimatedContainer(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      duration: Duration(milliseconds: 300),
                      height: 7,
                      width: index == _indexImage ? 20 : 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color:
                            index == _indexImage ? primaryColor : Colors.white,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

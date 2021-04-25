import 'dart:io';

import 'package:ala_kosan/helpers/constants.dart';
import 'package:ala_kosan/helpers/static_map.dart';
import 'package:ala_kosan/models/kosan.dart';
import 'package:ala_kosan/models/user_app.dart';
import 'package:ala_kosan/pages/payment/order_summary.dart';
import 'package:ala_kosan/providers/kosan_provider.dart';
import 'package:ala_kosan/providers/user_provider.dart';
import 'package:ala_kosan/shared/device.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/shared/utils.dart';
import 'package:ala_kosan/widgets/chip_type.dart';
import 'package:ala_kosan/widgets/facility_item.dart';
import 'package:ala_kosan/widgets/favorite_icon_button.dart';
import 'package:ala_kosan/widgets/user_circle_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
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
  Future<UserApp> _owner;
  bool _isLoading = false;

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
        ? Constants.googleMapsUrl(latitude, longitude)
        : Constants.googleMapsUrlForApple(latitude, longitude);
    final String appleMaps = Constants.appleMapsUrl(latitude, longitude);

    if (await canLaunch(maps)) {
      await launch(maps);
    } else if (await canLaunch(appleMaps)) {
      await launch(appleMaps);
    } else {
      throw "Tidak dapat membuka Url";
    }
  }

  void _launchWhatsapp(String phoneNumber) async {
    final url = Constants.whatsappApiUrl(phoneNumber);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw Exception("Tidak dapat membuka WhatsApp");
    }
  }

  void _contactOwner(String phoneNumber) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Hubungi pemilik",
                    style: contentTitle(context),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(EvaIcons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(EvaIcons.phoneCall),
                title: Text("Telepon $phoneNumber"),
                onTap: () {
                  launch("tel://$phoneNumber");
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(EvaIcons.messageCircle),
                title: Text("Chatting melalui WhatsApp"),
                onTap: () {
                  _launchWhatsapp(phoneNumber);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Kosan kosan = context.read<KosanProvider>().findKosanById(_id);
    _owner = context.read<UserProvider>().getOwner(kosan.ownerId);
    _mapUrl = Static.generateStaticMap(
        latitude: kosan.latitude, longitude: kosan.longitude);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  brightness: Brightness.dark,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _buildImageHeader(kosan),
                  ),
                  pinned: true,
                  actions: [
                    FavoriteIconButton(
                      kosan: kosan,
                    ),
                  ],
                  expandedHeight: 350 - paddingSafeDevice(context).top,
                  title: Text(kosan.name),
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
                    Divider(),
                    _buildFacility(context, kosan),
                    SizedBox(height: 16),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Info Tambahan",
                          style: contentTitle(context),
                        ),
                        SizedBox(height: 4),
                        Text(
                          kosan.additionalInfo,
                          style: onBoardSubtitle(context),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    _buildCardOwner(context),
                    SizedBox(height: 16),
                    Divider(),
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

  Widget _buildFacility(BuildContext context, Kosan kosan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Fasilitas Utama",
          style: contentTitle(context),
        ),
        SizedBox(height: 4),
        FacilityItem(
          facility: kosan.facility,
        ),
      ],
    );
  }

  Widget _buildCardOwner(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pemilik Kos", style: contentTitle(context)),
        SizedBox(height: 4),
        Card(
          elevation: 6,
          child: FutureBuilder<UserApp>(
            future: _owner,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userOwner = snapshot.data;
                return ListTile(
                  leading: UserCircleAvatar(
                    imageUrl: userOwner.imageUrl,
                    circleRadius: 18,
                  ),
                  title: Text(userOwner.name),
                  subtitle: Text(userOwner.phoneNumber),
                  trailing: IconButton(
                    icon: Icon(
                      EvaIcons.messageCircleOutline,
                      color: accentColor,
                    ),
                    onPressed: () => _contactOwner(userOwner.phoneNumber),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Tidak dapat memuat info owner");
              }
              return Center(
                child: SpinKitFadingCircle(
                  size: 50,
                  color: accentColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTitleKosan(Kosan kosan, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          kosan.name,
          style: contentTitle2(context).copyWith(
            fontSize: 24,
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
                kosan.availableRoom > 0
                    ? "${kosan.availableRoom} kamar tersedia"
                    : "Kamar penuh yaa..",
                style: TextStyle(
                  color: kosan.availableRoom < 3 ? Colors.red : Colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocation(Kosan kosan, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lokasi Kosan",
          style: contentTitle(context),
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(EvaIcons.pinOutline, size: 24),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                kosan.address,
                style: onBoardSubtitle(context),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () {
              showAlert(
                context,
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
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: _mapUrl,
                placeholder: (context, url) =>
                    LottieBuilder.asset("assets/lotties/placeholder.json"),
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
                height: 45,
                width: widthOfDevice(context) * 0.35,
                child: _isLoading
                    ? Center(
                        child: SpinKitFadingCircle(
                          color: accentColor,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: kosan.availableRoom > 0
                            ? () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await Provider.of<KosanProvider>(context,
                                        listen: false)
                                    .getKosan();
                                await Provider.of<UserProvider>(context,
                                        listen: false)
                                    .getCurrentUser();
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.of(context).pushNamed(
                                  OrderSummary.routeName,
                                  arguments: kosan.id,
                                );
                              }
                            : null,
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
      child: Container(
        color: Colors.white,
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
              itemBuilder: (context, index) => Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: kosan.images[_indexImage],
                    placeholder: (context, url) => LottieBuilder.asset(
                      "assets/lotties/placeholder.json",
                    ),
                    fit: BoxFit.cover,
                    height: 350,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).scaffoldBackgroundColor,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black54,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                            index == _indexImage ? accentColor : Colors.white,
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

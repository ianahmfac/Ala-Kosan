import 'package:ala_kosan/models/kosan.dart';
import 'package:ala_kosan/providers/kosan_provider.dart';
import 'package:ala_kosan/shared/device.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/shared/utils.dart';
import 'package:ala_kosan/widgets/chip_type.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailKos extends StatefulWidget {
  static const routeName = "/detail-kos";

  @override
  _DetailKosState createState() => _DetailKosState();
}

class _DetailKosState extends State<DetailKos> {
  String _id;
  String _cityName;
  int _indexImage = 0;

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

  @override
  Widget build(BuildContext context) {
    final Kosan kosan =
        Provider.of<KosanProvider>(context, listen: false).findKosanById(_id);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageHeader(kosan),
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
                          ChipType(
                            text: kosan.rating.toString(),
                            icon: EvaIcons.star,
                          ),
                          ChipType(text: kosan.type),
                        ],
                      ),
                      Text(
                        kosan.name,
                        style: contentTitle2(context),
                      ),
                      SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(EvaIcons.pinOutline),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              kosan.address,
                              style: onBoardSubtitle(context)
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
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
                                style: onBoardSubtitle(context)
                                    .copyWith(fontSize: 14),
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
          ),
        ],
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

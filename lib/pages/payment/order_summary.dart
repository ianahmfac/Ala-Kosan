import 'package:ala_kosan/providers/kosan_provider.dart';
import 'package:ala_kosan/shared/device.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OrderSummary extends StatefulWidget {
  static const routeName = "/order-summary";

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  String _id;
  int _month = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _id = ModalRoute.of(context).settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    final kos =
        Provider.of<KosanProvider>(context, listen: false).findKosanById(_id);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("Order Summary"),
        previousPageTitle: "Back",
      ),
      body: ListView(
        children: [
          _buildContentTitle(context, "Kosan Booked"),
          Container(
            height: 150,
            margin: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: kos.images[0],
                  height: 150,
                  width: widthOfDevice(context) * 0.3,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      LottieBuilder.asset("assets/lotties/placeholder.json"),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kos.name,
                        style: contentTitle(context),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                            child: Icon(
                              EvaIcons.minus,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "$_month bln",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 8),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                            child: Icon(
                              EvaIcons.plus,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildContentTitle(context, "Customer Info"),
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        child: SizedBox(
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(EvaIcons.creditCard),
            label: Text("Book Now"),
          ),
        ),
      ),
    );
  }

  Widget _buildContentTitle(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[100],
      child: Text(
        title,
        style: contentTitle(context).copyWith(
          color: Colors.grey,
          fontSize: 18,
        ),
      ),
    );
  }
}

import 'package:ala_kosan/models/kosan.dart';
import 'package:ala_kosan/models/transaction_model.dart';
import 'package:ala_kosan/models/user_app.dart';
import 'package:ala_kosan/pages/payment/pin_input_page.dart';
import 'package:ala_kosan/providers/kosan_provider.dart';
import 'package:ala_kosan/providers/user_provider.dart';
import 'package:ala_kosan/shared/device.dart';
import 'package:ala_kosan/shared/platform_alert_dialog.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/shared/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  bool _isLoading = false;
  UserApp _owner;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    Map<String, String> args = ModalRoute.of(context).settings.arguments;
    _id = args["kosanId"];
    _owner = await Provider.of<UserProvider>(context, listen: false)
        .getOwner(args["ownerId"]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final kos =
        Provider.of<KosanProvider>(context, listen: false).findKosanById(_id);
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ..._kosanBooked(kos),
            _ownerInfo(context, kos),
            _buildContentTitle(context, "Detail Payment"),
            _buildTitleContentRow(
              "Harga $_month bulan",
              convertCurrency((_month * kos.price).toDouble()),
            ),
            _buildTitleContentRow(
              "Biaya Admin\n(5% Harga Kos)",
              convertCurrency((_month * kos.price) * 0.05),
            ),
            Divider(),
            _buildTitleContentRow(
              "Total Bayar",
              convertCurrency((_month * kos.price).toDouble() +
                  (_month * kos.price) * 0.05),
              primaryColor,
              FontWeight.bold,
            ),
            _buildTitleContentRow(
              "Saldo Ku",
              convertCurrency(user.balance.toDouble()),
              (user.balance.toDouble() >
                      (_month * kos.price).toDouble() +
                          (_month * kos.price) * 0.05
                  ? Colors.green
                  : Colors.red),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
        child: SizedBox(
          height: 50,
          child: _isLoading
              ? Center(
                  child: SpinKitFadingCircle(
                    color: accentColor,
                  ),
                )
              : OutlinedButton.icon(
                  onPressed: user.balance.toDouble() >=
                          (_month * kos.price).toDouble() +
                              (_month * kos.price) * 0.05
                      ? () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .getCurrentUser();
                          final owner = await Provider.of<UserProvider>(context,
                                  listen: false)
                              .getOwner(kos.ownerId);
                          if (user.balance.toDouble() >=
                              (_month * kos.price).toDouble() +
                                  (_month * kos.price) * 0.05) {
                            final transaction = TransactionModel(
                              id: "AlaKosan-${DateTime.now()}",
                              kosanId: kos.id,
                              kosanName: kos.name,
                              kosanImageUrl: kos.images[0],
                              kosanAddress: kos.address,
                              month: _month,
                              priceInAMonth: kos.price.toDouble(),
                              totalPrice: (_month * kos.price).toDouble() +
                                  (_month * kos.price) * 0.05,
                              ownerName: owner.name,
                              ownerPhoneNumber: owner.phoneNumber,
                              createdAt: DateTime.now(),
                              availableRoom: kos.availableRoom,
                              balance: user.balance,
                            );
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.of(context).pushNamed(
                              PinInputPage.routeName,
                              arguments: transaction,
                            );
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            PlatformAlertDialog(
                              titleText: 'Gagal Booking',
                              contentText:
                                  'Saldo kamu tidak cukup nih, yuk isi saldo kamu.',
                              buttonDialogText: 'OK',
                            ).show(context);
                          }
                        }
                      : null,
                  icon: Icon(EvaIcons.creditCard),
                  label: Text("Book Now"),
                ),
        ),
      ),
    );
  }

  Widget _buildTitleContentRow(String title, String content,
      [Color color = primaryColor, FontWeight weight = FontWeight.normal]) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          Text(
            title,
            style: contentBody(context),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              content,
              style: contentBody(context).copyWith(
                fontWeight: weight,
                color: color,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ownerInfo(BuildContext context, Kosan kos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildContentTitle(context, "Owner Info"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleandContent(
              "Nama Pemilik",
              _owner != null ? _owner.name : "Loading...",
            ),
            _buildTitleandContent(
              "Nomor HP",
              _owner != null ? _owner.phoneNumber : "Loading...",
            ),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildTitleandContent(String title, String content) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            content,
            style: contentTitle(context).copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }

  List<Widget> _kosanBooked(Kosan kos) {
    return [
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: contentTitle(context).copyWith(fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Text(
                    kos.address,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      InkWell(
                        onTap: _month == 1
                            ? null
                            : () {
                                setState(() {
                                  _month--;
                                });
                              },
                        child: CircleAvatar(
                          backgroundColor:
                              _month == 1 ? Colors.grey : primaryColor,
                          radius: 14,
                          child: Icon(
                            EvaIcons.minus,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "$_month bln",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _month++;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 14,
                          child: Icon(
                            EvaIcons.plus,
                            color: Colors.white,
                          ),
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
    ];
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

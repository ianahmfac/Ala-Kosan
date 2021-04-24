import 'package:ala_kosan/shared/device.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataFound extends StatelessWidget {
  final String message;

  const NoDataFound({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: widthOfDevice(context) * 0.8,
              child: LottieBuilder.asset("assets/lotties/not_found.json"),
            ),
            Text(
              message,
              style: contentTitle(context).copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

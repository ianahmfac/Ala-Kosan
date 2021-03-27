import 'package:ala_kosan/models/facility.dart';
import 'package:ala_kosan/shared/device.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FacilityItem extends StatelessWidget {
  final Facility facility;

  const FacilityItem({Key key, @required this.facility}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final path = "assets/images/";
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        runSpacing: 8,
        spacing: 8,
        children: [
          if (facility.hasBed)
            _buildFacility(
              context,
              assetPath: "$path/bed.svg",
              text: "Tempat Tidur",
            ),
          _buildFacility(
            context,
            assetPath: "$path/bathtub.svg",
            text: (facility.isInnerToilet) ? "KM. Dalam" : "KM. Luar",
          ),
          if (facility.hasCupboard)
            _buildFacility(
              context,
              assetPath: "$path/cupboard.svg",
              text: "Lemari Pakaian",
            ),
          _buildFacility(
            context,
            assetPath: (facility.hasAirConditioner)
                ? "$path/air-conditioner.svg"
                : "$path/fan.svg",
            text:
                facility.hasAirConditioner ? "Air Conditioner" : "Kipas Angin",
          ),
          if (facility.hasWifi)
            _buildFacility(
              context,
              assetPath: "$path/wifi.svg",
              text: "WiFi Gratis",
            ),
          if (facility.hasWorkbench)
            _buildFacility(
              context,
              assetPath: "$path/workbench.svg",
              text: "Meja Kerja",
            ),
          _buildFacility(
            context,
            assetPath: facility.isIncludeElectricity
                ? "$path/electricity.svg"
                : "$path/no-electricity.svg",
            text: facility.isIncludeElectricity
                ? "Include Listrik"
                : "Listrik Pribadi",
          ),
          _buildFacility(
            context,
            assetPath: facility.hasParkingLot
                ? "$path/parking.svg"
                : "$path/no-parking.svg",
            text: facility.hasParkingLot ? "Parkir Gratis" : "Parkir Bayar",
          ),
        ],
      ),
    );
  }

  Widget _buildFacility(BuildContext context,
      {@required String assetPath, @required String text}) {
    return Card(
      elevation: 4,
      child: Container(
        height: 100,
        width: widthOfDevice(context) / 3 - 24,
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            SvgPicture.asset(
              assetPath,
              color: primaryColor,
              height: 50,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Spacer(),
            Text(
              text,
              style: TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

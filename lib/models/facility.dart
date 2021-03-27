import 'package:flutter/foundation.dart';

class Facility {
  final bool hasAirConditioner;
  final bool hasBed;
  final bool hasCupboard;
  final bool isInnerToilet;
  final bool hasWifi;
  final bool hasWorkbench;
  final bool isIncludeElectricity;
  final bool hasParkingLot;
  Facility({
    @required this.hasAirConditioner,
    @required this.hasBed,
    @required this.hasCupboard,
    @required this.isInnerToilet,
    @required this.hasWifi,
    @required this.hasWorkbench,
    @required this.isIncludeElectricity,
    @required this.hasParkingLot,
  });
}

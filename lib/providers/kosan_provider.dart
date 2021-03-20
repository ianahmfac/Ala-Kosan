import 'package:ala_kosan/models/kosan.dart';
import 'package:flutter/material.dart';

class KosanProvider with ChangeNotifier {
  List<Kosan> _kosan = [];

  List<Kosan> get kosan => _kosan;

  void getKosan() async {
    await Future.delayed(Duration(seconds: 1));
    _kosan = kosanDummy;
    notifyListeners();
  }
}

import 'package:ala_kosan/models/kosan.dart';
import 'package:flutter/material.dart';

class KosanProvider with ChangeNotifier {
  List<Kosan> _listOfKosan = [];
  List<Kosan> get listOfKosan => _listOfKosan;

  void getKosan() async {
    await Future.delayed(Duration(seconds: 1));
    _listOfKosan = kosanDummy;
    notifyListeners();
  }

  Kosan findKosanById(String id) {
    return _listOfKosan.firstWhere((element) => element.id == id);
  }
}

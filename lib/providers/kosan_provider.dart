import 'package:ala_kosan/helpers/dummy_kosan.dart';
import 'package:ala_kosan/models/kosan.dart';
import 'package:ala_kosan/services/kosan_service.dart';
import 'package:flutter/material.dart';

class KosanProvider with ChangeNotifier {
  List<Kosan> _listOfKosan = [];
  List<Kosan> get listOfKosan => _listOfKosan;

  List<Kosan> get listOfKosanHome => _listOfKosan.take(5).toList();

  void getKosan() async {
    _listOfKosan = await KosanService.getKosan()
      ..shuffle();
    notifyListeners();
  }

  Kosan findKosanById(String id) {
    return _listOfKosan.firstWhere((element) => element.id == id);
  }
}

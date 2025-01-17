import 'package:ala_kosan/models/city.dart';
import 'package:ala_kosan/services/city_service.dart';
import 'package:flutter/material.dart';

class CityProvider with ChangeNotifier {
  List<City> _cities = [];

  List<City> get cities => _cities;

  Future<void> getCities() async {
    _cities = await CityService.getCity()
      ..shuffle();
    notifyListeners();
  }

  City findCityById(String id) {
    return _cities.firstWhere((city) => city.id == id);
  }

  void userSignOut() {
    _cities = [];
    notifyListeners();
  }
}

import 'package:ala_kosan/models/city.dart';
import 'package:ala_kosan/services/city_service.dart';
import 'package:flutter/material.dart';

class CityProvider with ChangeNotifier {
  List<City> _cities = [];

  List<City> get cities => _cities;
  List<City> get homePageCities => _cities.take(5).toList();

  Future<void> getCities() async {
    _cities = await CityService.getCity()
      ..shuffle();
    notifyListeners();
  }
}

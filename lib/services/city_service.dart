import 'package:ala_kosan/models/city.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CityService {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection("cities");

  static Future<List<City>> getCity() async {
    QuerySnapshot snapshot = await _ref.get();
    List<City> cities = snapshot.docs
        .map(
          (city) => City.fromMap(city.data()),
        )
        .toList();
    return cities;
  }
}

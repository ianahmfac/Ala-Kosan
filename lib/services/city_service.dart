import 'package:ala_kosan/models/city.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CityService {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection("cities");

  static Future<List<City>> getCity() async {
    QuerySnapshot snapshot = await _ref.get();
    List<City> cities = snapshot.docs
        .map((city) => City(
              id: city.data()["id"],
              city: city.data()["city"],
              image: city.data()["image"],
              desc: city.data()["description"],
            ))
        .toList();
    return cities;
  }
}

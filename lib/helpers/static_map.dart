import 'package:ala_kosan/helpers/ApiKey.dart';

class Static {
  static String generateStaticMap({double latitude, double longitude}) {
    return "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/geojson(%7B%22type%22%3A%22Point%22%2C%22coordinates%22%3A%5B$longitude%2C$latitude%5D%7D)/$longitude,$latitude,12/500x300?access_token=${ApiKey.mapboxKey}";
  }
}

class Constants {
  static const List<Map<String, String>> onboardInfo = [
    {
      "title": "Kosan Nyaman",
      "subtitle":
          "Ala Kosan menyediakan berbagai kosan yang nyaman dan sudah direview dengan baik",
      "image": "assets/lotties/comfort.json",
    },
    {
      "title": "Kemudahan Pencarian",
      "subtitle":
          "Gunakan fitur pencarian untuk Lokasi Kosan yang lebih spesifik",
      "image": "assets/lotties/search.json",
    },
    {
      "title": "Harga Bersahabat",
      "subtitle":
          "Berbagai Kosan dengan harga yang bersahabat untuk semua kalangan",
      "image": "assets/lotties/money.json",
    },
  ];

  static bool isValidEmail(String email) {
    bool regex = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return regex;
  }

  static String googleMapsUrl(double latitude, double longitude) =>
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

  static String googleMapsUrlForApple(double latitude, double longitude) =>
      "comgooglemaps://?saddr=&daddr=$latitude,$longitude&directionsmode=driving";

  static String appleMapsUrl(double latitude, double longitude) =>
      "https://maps.apple.com/?q=$latitude,$longitude";

  static String whatsappApiUrl(String phoneNumber) =>
      "https://api.whatsapp.com/send/?phone=$phoneNumber&text&app_absent=0";
}

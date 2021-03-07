class Constants {
  static const List<Map<String, String>> onboardInfo = [
    {
      "title": "Kosan Nyaman",
      "subtitle":
          "Ala Kosan menyediakan berbagai kosan yang nyaman dan sudah direview dengan baik",
      "image": "assets/images/onboard-comfort-kos.png",
    },
    {
      "title": "Kemudahan Pencarian",
      "subtitle": "Gunakan fitur pencarian untuk Kosan yang lebih spesifik",
      "image": "assets/images/onboard-search-kos.png",
    },
    {
      "title": "Harga Bersahabat",
      "subtitle":
          "Berbagai Kosan dengan harga yang bersahabat dari semua kalangan",
      "image": "assets/images/onboard-save-money.png",
    },
  ];

  static bool isValidEmail(String email) {
    bool regex = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return regex;
  }
}

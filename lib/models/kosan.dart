import 'package:flutter/foundation.dart';

class Kosan {
  final String id;
  final String name;
  final String cityId;
  final String address;
  final double longitude;
  final double latitude;
  final List<String> images;
  final String type;
  final int price;
  final int availableRoom;
  final double rating;
  final double discount;
  Kosan({
    @required this.id,
    @required this.name,
    @required this.cityId,
    @required this.address,
    @required this.longitude,
    @required this.latitude,
    @required this.images,
    @required this.type,
    @required this.price,
    @required this.availableRoom,
    this.rating = 0.0,
    this.discount = 0.0,
  });

  Kosan copyWith({
    String id,
    String name,
    String cityId,
    String address,
    double longitude,
    double latitude,
    List<String> images,
    String type,
    int price,
    int availableRoom,
    double rating,
    double discount,
  }) {
    return Kosan(
      id: id ?? this.id,
      name: name ?? this.name,
      cityId: cityId ?? this.cityId,
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      images: images ?? this.images,
      type: type ?? this.type,
      price: price ?? this.price,
      availableRoom: availableRoom ?? this.availableRoom,
      rating: rating ?? this.rating,
      discount: discount ?? this.discount,
    );
  }
}

List<Kosan> kosanDummy = [
  Kosan(
    id: "001",
    name: "Griya Aziza",
    cityId: "OxaWMiEW03abeIU8ktRv",
    address: "Jl. G2. No. 22, Slipi, Palmerah, Jakarta Barat",
    latitude: -6.1900496,
    longitude: 106.8001794,
    images: [
      "https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1556911220-bff31c812dba?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2035&q=80",
    ],
    type: "Campur",
    availableRoom: 9,
    price: 1800000,
    rating: 4.97,
  ),
  Kosan(
    id: "002",
    name: "Kos Vida View",
    cityId: "BfWVFC0OUl5y20keeI4B",
    address: "Jl. Topaz Raya No.121, Masale, Panakkukang, Makassar",
    latitude: -5.1537158,
    longitude: 119.438477,
    images: [
      "https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1951&q=80",
      "https://images.unsplash.com/photo-1580587771525-78b9dba3b914?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1567&q=80",
      "https://images.unsplash.com/photo-1564540583246-934409427776?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1935&q=80",
      "https://images.unsplash.com/photo-1598546720078-8659863bc47d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
    ],
    type: "Pria",
    price: 2500000,
    availableRoom: 5,
    rating: 4.0,
  ),
  Kosan(
    id: "003",
    name: "Sweet Van Java Kos",
    cityId: "5zvaObbGQsgFrTg03Jae",
    address: "Jl. Martadinata No. 118, Bandung",
    latitude: -6.9105841,
    longitude: 107.6243361,
    images: [
      "https://images.unsplash.com/photo-1586105251261-72a756497a11?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1467&q=80",
      "https://images.unsplash.com/photo-1568605114967-8130f3a36994?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1604709177225-055f99402ea3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1565538810643-b5bdb714032a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80",
    ],
    type: "Wanita",
    availableRoom: 1,
    price: 1499000,
    rating: 3.5,
  ),
];

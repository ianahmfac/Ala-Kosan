import 'package:ala_kosan/models/facility.dart';
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
  final String ownerId;
  final int availableRoom;
  final Facility facility;
  final String additionalInfo;
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
    @required this.ownerId,
    @required this.availableRoom,
    @required this.facility,
    this.additionalInfo = "Tidak ada info tambahan.",
    this.rating = 0.0,
    this.discount = 0.0,
  });

  factory Kosan.fromFirestore(Map<String, dynamic> doc) {
    return Kosan(
      id: doc["id"],
      name: doc["name"],
      cityId: doc["cityId"],
      address: doc["address"],
      longitude: doc["longitude"],
      latitude: doc["latitude"],
      images: (doc["images"] as List).map((image) => image.toString()).toList(),
      type: doc["type"],
      price: doc["price"],
      ownerId: doc["ownerId"],
      availableRoom: doc["availableRoom"],
      facility: Facility(
        hasAirConditioner: doc["hasAirConditioner"],
        hasBed: doc["hasBed"],
        hasCupboard: doc["hasCupboard"],
        isInnerToilet: doc["isInnerToilet"],
        hasWifi: doc["hasWifi"],
        hasWorkbench: doc["hasWorkbench"],
        isIncludeElectricity: doc["isIncludeElectricity"],
        hasParkingLot: doc["hasParkingLot"],
      ),
      additionalInfo: doc["additionalInfo"],
      discount: doc["discount"],
      rating: doc["rating"],
    );
  }

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
    String ownerId,
    int availableRoom,
    Facility facility,
    String additionalInfo,
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
      ownerId: ownerId ?? this.ownerId,
      availableRoom: availableRoom ?? this.availableRoom,
      facility: facility ?? this.facility,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      rating: rating ?? this.rating,
      discount: discount ?? this.discount,
    );
  }
}

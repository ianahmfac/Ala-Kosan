import 'package:ala_kosan/models/kosan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KosanService {
  static final _collectionReference =
      FirebaseFirestore.instance.collection("kosan");

  static Future<void> setKosan(Kosan kosan) async {
    try {
      final documentRef = _collectionReference.doc();
      documentRef.set({
        "id": documentRef.id,
        "name": kosan.name,
        "cityId": kosan.cityId,
        "address": kosan.address,
        "longitude": kosan.longitude,
        "latitude": kosan.latitude,
        "images": kosan.images,
        "type": kosan.type,
        "price": kosan.price,
        "ownerId": kosan.ownerId,
        "availableRoom": kosan.availableRoom,
        "hasAirConditioner": kosan.facility.hasAirConditioner,
        "hasBed": kosan.facility.hasBed,
        "hasCupboard": kosan.facility.hasCupboard,
        "isInnerToilet": kosan.facility.isInnerToilet,
        "hasWifi": kosan.facility.hasWifi,
        "hasWorkbench": kosan.facility.hasWorkbench,
        "isIncludeElectricity": kosan.facility.isIncludeElectricity,
        "hasParkingLot": kosan.facility.hasParkingLot,
        "additionalInfo": kosan.additionalInfo,
        "rating": kosan.rating,
        "discount": kosan.discount,
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw "Terjadi kesalahan, coba lagi nanti.";
    }
  }

  static Future<List<Kosan>> getKosan() async {
    final querySnapshot = await _collectionReference.get();
    List<Kosan> kosan = querySnapshot.docs
        .map((kos) => Kosan.fromFirestore(kos.data()))
        .toList();
    return kosan;
  }
}

import 'package:ala_kosan/models/transaction_model.dart';
import 'package:ala_kosan/models/user_app.dart';
import 'package:ala_kosan/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("users");

  static Future<void> setUser(UserApp user) async {
    _collectionReference.doc(user.id).set({
      "email": user.email,
      "name": user.name,
      "phoneNumber": user.phoneNumber,
      "imageUrl": user.imageUrl ?? "",
      "balance": user.balance,
      "pin": user.pin,
    });
  }

  static Future<UserApp> getUser(String id) async {
    DocumentSnapshot doc = await _collectionReference.doc(id).get();
    Map<String, dynamic> user = doc.data();
    return UserApp(
      id: id,
      name: user["name"],
      email: user["email"],
      phoneNumber: user["phoneNumber"],
      imageUrl: user["imageUrl"],
      balance: user["balance"],
      pin: user["pin"],
    );
  }

  static Future<void> setFavorite(String kosanId, bool favorite) async {
    _collectionReference
        .doc(AuthService.currentUid)
        .collection("favorites")
        .doc(kosanId)
        .set({
      "favorite": favorite,
    });
  }

  static Future<Map<String, dynamic>> getFavorite() async {
    final snapshot = await _collectionReference
        .doc(AuthService.currentUid)
        .collection("favorites")
        .get();
    Map<String, dynamic> returnValue = {};
    snapshot.docs
        .forEach((kos) => returnValue[kos.id] = kos.data()["favorite"]);
    return returnValue;
  }

  static Future<void> setMyTransaction(TransactionModel transaction) async {
    try {
      await _collectionReference
          .doc(AuthService.currentUid)
          .collection("transactions")
          .doc(transaction.id)
          .set(transaction.toMap());
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}

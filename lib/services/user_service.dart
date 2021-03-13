import 'package:ala_kosan/models/user_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("users");

  static Future<void> setUser(UserApp user) async {
    _collectionReference.doc(user.id).set({
      "email": user.email,
      "name": user.name,
      "phoneNumber": user.phoneNumber,
      "imageUrl": user.imageUrl,
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
    );
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadImageService {
  static Future<String> uploadAndGetImageUrl(String email, File image) async {
    final Reference _userProfileRef = FirebaseStorage.instance.ref();
    String returnImageUrl;
    if (image != null) {
      await _userProfileRef
          .child("profile_picture/$email.png")
          .putFile(image)
          .whenComplete(() async {
        returnImageUrl = await _userProfileRef
            .child("profile_picture/$email.png")
            .getDownloadURL();
      });
      return returnImageUrl;
    }
    return "";
  }

  static void deleteImage(String email, File image) async {
    final _userProfileRef = FirebaseStorage.instance.ref();
    if (image == null) return;
    await _userProfileRef.child("profile_picture/$email.png").delete();
  }
}

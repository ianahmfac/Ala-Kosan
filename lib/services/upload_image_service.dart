import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadImageService {
  static final Reference _userProfileRef =
      FirebaseStorage.instance.ref("profile_picture");

  static Future<String> uploadAndGetImageUrl(String email, File image) async {
    if (image != null) {
      UploadTask imageUpload =
          _userProfileRef.child("$email.png").putFile(image);
      return await imageUpload.snapshot.ref.getDownloadURL();
    }
    return "";
  }

  static void deleteImage(String email, File image) async {
    if (image == null) return;
    await _userProfileRef.child("$email.png").delete();
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class UploadImageService {
  static final Reference _userProfileRef =
      FirebaseStorage.instance.ref("profile_picture");

  static Future<String> uploadAndGetImageUrl(File image) async {
    if (image != null) {
      String imageUrl = "";
      final String imagePath = path.basename(image.path);
      UploadTask imageUpload = _userProfileRef.child(imagePath).putFile(image);
      await imageUpload.whenComplete(() async {
        imageUrl = await _userProfileRef.child(imagePath).getDownloadURL();
      });
      return imageUrl;
    }
    return "";
  }

  static void deleteImage(String imageUrl) async {
    if (imageUrl == null) return;
    await _userProfileRef.child(path.basename(imageUrl)).delete();
  }
}

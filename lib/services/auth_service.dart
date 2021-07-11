import 'dart:io';

import 'package:ala_kosan/models/user_app.dart';
import 'package:ala_kosan/services/upload_image_service.dart';
import 'package:ala_kosan/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message;
    } catch (e) {
      throw Exception("Terjadi kesalahan, silahkan coba lagi nanti.");
    }
  }

  static Future<void> signUp(String email, String password, String name,
      String phoneNumber, File image) async {
    try {
      String imageUrl =
          await UploadImageService.uploadAndGetImageUrl(email, image);
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserApp user = UserApp(
        id: cred.user.uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        imageUrl: imageUrl,
        pin: "", //TODO PIN
      );
      UserService.setUser(user);
    } on FirebaseAuthException catch (e) {
      UploadImageService.deleteImage(email, image);
      throw e.message;
    } catch (e) {
      UploadImageService.deleteImage(email, image);
      print(e.toString());
      throw e;
    }
  }

  static void signOut() => _auth.signOut();

  static Stream<User> get userSignIn => _auth.authStateChanges();

  static String get currentUid => _auth.currentUser.uid;
}

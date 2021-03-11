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

  static Future<void> signUp(String email, String password) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message;
    } catch (e) {
      throw Exception("Terjadi kesalahan, silahkan coba lagi nanti.");
    }
  }

  static void signOut() => _auth.signOut();

  static Stream<User> get userSignIn => _auth.authStateChanges();

  static String get currentUid => _auth.currentUser.uid;
}

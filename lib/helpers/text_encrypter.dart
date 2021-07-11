import 'package:ala_kosan/helpers/ApiKey.dart';
import 'package:encrypt/encrypt.dart';

class TextEncrypter {
  static String encryptText(String text) {
    final key = Key.fromUtf8(ApiKey.encryptKey);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  static String decryptText(String text) {
    final encrypted = Encrypted.fromBase64(text);
    final key = Key.fromUtf8(ApiKey.encryptKey);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';

class SecurityUtils {
  // Argon2id parameters
  static const int iterations = 2;
  static const int memory = 65536; // 64MB
  static const int parallelism = 1;
  static const int hashLength = 32;

  static String generateSalt() {
    final random = Random.secure();
    final saltBytes = Uint8List.fromList(List.generate(16, (_) => random.nextInt(256)));
    return base64.encode(saltBytes);
  }

  static Future<String> hashValue(String input, String saltBase64) async {
    final salt = base64.decode(saltBase64);

    final argon2id = Argon2id(
      iterations: iterations,
      memory: memory,
      parallelism: parallelism,
      hashLength: hashLength,
    );

    final secretKey = await argon2id.deriveKeyFromPassword(
      password: input,
      nonce: salt,
    );

    final bytes = await secretKey.extractBytes();
    return base64.encode(bytes);
  }

  static Future<bool> verifyValue(String input, String saltBase64, String storedHashBase64) async {
    final calculatedHash = await hashValue(input, saltBase64);
    return calculatedHash == storedHashBase64;
  }
}

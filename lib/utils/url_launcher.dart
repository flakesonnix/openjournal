import 'dart:io';
import 'package:flutter/services.dart';

class UrlLauncher {
  static const _channel = MethodChannel('org.openpsychonaut.openjournal/launcher');

  static Future<void> openUrl(String url) async {
    if (Platform.isLinux) {
      try {
        await _channel.invokeMethod('open_url', {'url': url});
      } on PlatformException catch (e) {
        print("Failed to open URL on Linux: '${e.message}'.");
      }
    } else {
      // TODO: Implement other platforms using standard url_launcher if needed
      // For now focusing on Linux stability.
    }
  }
}

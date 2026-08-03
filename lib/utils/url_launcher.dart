import 'package:url_launcher/url_launcher.dart' as ul;

class UrlLauncher {
  static Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await ul.canLaunchUrl(uri)) {
      await ul.launchUrl(uri, mode: ul.LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:openjournal/models/substance/substance.dart';

void main() {
  test('Parse Substances.json', () {
    final file = File('assets/Substances.json');
    final jsonStr = file.readAsStringSync();
    final data = json.decode(jsonStr);
    final List<dynamic> substanceList = data['substances'];

    for (var s in substanceList) {
      try {
        Substance.fromJson(s);
      } catch (e) {
        print("Error parsing substance: ${s['name']}");
        print(e);
        rethrow;
      }
    }
  });
}

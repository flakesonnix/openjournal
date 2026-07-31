import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:openjournal/models/substance/substance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubstanceService {
  List<Substance> _substances = [];

  Future<void> init() async {
    final String response = await rootBundle.loadString('assets/Substances.json');
    final data = json.decode(response);
    final List<dynamic> substanceList = data['substances'];
    _substances = substanceList.map((s) => Substance.fromJson(s)).toList();
  }

  List<Substance> get substances => _substances;

  // Added for unit testing
  set substances(List<Substance> value) => _substances = value;

  List<Substance> searchSubstances(String query) {
    if (query.isEmpty) return [];
    return _substances.where((s) {
      final lowerQuery = query.toLowerCase();
      return s.name.toLowerCase().contains(lowerQuery) ||
          s.commonNames.any((name) => name.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}

final substanceServiceProvider = Provider<SubstanceService>((ref) {
  return SubstanceService();
});

import 'dart:developer';

class MatchingPairsData {
  final Map<String, String> pairs;

  const MatchingPairsData({
    required this.pairs,
  });

  factory MatchingPairsData.fromJson(Map<String, dynamic> json) {
    try {
      log(json['pairs'].toString());
      return MatchingPairsData(
        pairs: Map<String, String>.from(json['pairs']),
      );
    } catch (e) {
      throw const FormatException('Failed to load Data.');
    }
  }
}

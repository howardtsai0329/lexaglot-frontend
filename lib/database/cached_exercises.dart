import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lexaglot/constants/constants.dart';
import 'package:lexaglot/database/login.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_data.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_view.dart';
import 'package:lexaglot/excercises/translate_sentence/translate_sentence_data.dart';
import 'package:lexaglot/excercises/translate_sentence/translate_sentence_view.dart';

class GeneralExercise {
  final String id;
  final String type;
  final Map<String, dynamic> data;

  const GeneralExercise({
    required this.id,
    required this.type,
    required this.data,
  });

  factory GeneralExercise.fromJson(Map<String, dynamic> json) {
    dev.log('User Detail JSON: $json');
    try {
      return GeneralExercise(
        id: json['_id'] as String,
        type: json['type'] as String,
        data: json['data'] as Map<String, dynamic>,
      );
    } catch (e) {
      dev.log('Error parsing User Detail: $e');
      throw const FormatException('Failed to load Next Exercise.');
    }
  }
}

Future<List<Widget Function(BuildContext, VoidCallback)>> fetchCachedExercise(BuildContext context) async {
  const url = '$apiLink/cached-exercises/eng';
  final List<Widget Function(BuildContext, VoidCallback)> cachedExercise = [];

  try {
    var token = await getToken() ?? '';
    if (token.isEmpty) {
      throw const FormatException('No tokens returned');
    } else if (isTokenExpired(token)) {
      token = await refreshToken();
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;

      for (final exercise in jsonData) {
        final output = GeneralExercise.fromJson(
          exercise as Map<String, dynamic>,
        );

        switch (output.type) {
          case 'translate':
            final data = TranslateExerciseData.fromJson(output.data);
            cachedExercise.add((context, next) => TranslateSentenceView(data: data, onNext: next));
            break;

          case 'matching':
            final data = MatchingPairsData.fromJson(output.data);
            cachedExercise.add((context, next) => MatchingPairsView(data: data, onNext: next));
            break;

          default:
            dev.log('Unsupported exercise type: ${output.type}');
            throw Exception('Unsupported exercise type: ${output.type}');
        }
      }
    } else {
      dev.log('Failed to fetch exercise: ${response.statusCode}');
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
    }
  } catch (e) {
    dev.log('Error fetching and navigating: $e');
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
  }

  return cachedExercise;
}
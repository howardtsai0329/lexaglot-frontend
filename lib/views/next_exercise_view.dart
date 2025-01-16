import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_data.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_view.dart';
import 'package:lexaglot/excercises/translate_sentence/translate_sentence_data.dart';
import 'package:lexaglot/database/login.dart';
import 'package:lexaglot/excercises/translate_sentence/translate_sentence_view.dart';

class GetNextExercise {
  final String id;
  final String type;
  final Map<String, dynamic> data;

  const GetNextExercise({
    required this.id,
    required this.type,
    required this.data,
  });

  factory GetNextExercise.fromJson(Map<String, dynamic> json) {
    dev.log('User Detail JSON: $json');
    try {
      return GetNextExercise(
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

class NextExerciseScreen extends StatefulWidget {
  const NextExerciseScreen({super.key});

  @override
  State<NextExerciseScreen> createState() => _NextExerciseScreenState();
}

class _NextExerciseScreenState extends State<NextExerciseScreen> {
  bool _isLoading = true; // Start in loading state

  @override
  void initState() {
    super.initState();
    fetchNextExercise();
  }

  Future<void> fetchNextExercise() async {
    const url = 'https://api.lexaglot.com/next_exercise?language=eng';
    String token = await getToken() ?? '';

    if (token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No tokens returned')),
      );
      return;
    } else if (isTokenExpired(token)) {
      token = await refreshToken();
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final output = GetNextExercise.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
        );

        switch (output.type) {
          case 'translate':
            final data = TranslateExerciseData.fromJson(output.data);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return TranslateSentenceView(
                    data: data,
                    onNext: () => {},
                  );
                },
              ),
            );
            break;

          case 'matching':
            final data = MatchingPairsData.fromJson(output.data);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return MatchingPairsView(
                    data: data,
                    onNext: () => {},
                  );
                },
              ),
            );
            break;

          default:
            throw Exception('Unsupported exercise type: ${output.type}');
        }
      } else {
        dev.log('Failed to fetch exercise: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      dev.log('Error fetching and navigating: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator if fetching fails
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next Exercise')),
      body: Stack(
        children: [
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

class TranslateExerciseData {
  final String inputLanguage;
  final String outputLanguage;
  final String inputSentence;
  final List<String> outputSentences;
  final List<String> chunkOptions;

  const TranslateExerciseData({
    required this.inputLanguage,
    required this.outputLanguage,
    required this.inputSentence,
    required this.outputSentences,
    required this.chunkOptions,
  });

  factory TranslateExerciseData.fromJson(Map<String, dynamic> json) {
    dev.log('Data JSON: $json');
    try {
      return TranslateExerciseData(
        inputLanguage: json['input_language'] as String,
        outputLanguage: json['output_language'] as String,
        inputSentence: json['input_sentence'] as String,
        outputSentences: List<String>.from(json['output_sentences']),
        chunkOptions: List<String>.from(json['chunk_options']),
      );
    } catch (e) {
      dev.log('Error parsing Data: $e');
      throw const FormatException('Failed to load Data.');
    }
  }

  @override
  String toString() {
    return 'Input Language: $inputLanguage\n'
        'Output Language: $outputLanguage\n'
        'Input Sentence: $inputSentence\n'
        'Output Sentences: ${outputSentences.join(", ")}\n'
        'Chunk Options: ${chunkOptions.join(", ")}';
  }
}

class Exercise {
  final String type;
  final TranslateExerciseData data;

  const Exercise({
    required this.type,
    required this.data,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    dev.log('Exercise JSON: $json');
    try {
      return Exercise(
        type: json['type'] as String,
        data: TranslateExerciseData.fromJson(json['data'] as Map<String, dynamic>),
      );
    } catch (e) {
      dev.log('Error parsing Exercise: $e');
      throw const FormatException('Failed to load Exercise.');
    }
  }
}

Future<Exercise> fetchExercise() async {
  const url = 'http://172.24.105.161:8000/exercise/676f6768de36cfc42c3e7dcf';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    dev.log('Response: ${response.body}');
    return Exercise.fromJson(
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
    );
  } else {
    dev.log('Failed to fetch Exercise: ${response.statusCode}');
    throw Exception('Failed to load Exercise');
  }
}

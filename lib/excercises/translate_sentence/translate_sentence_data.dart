import 'dart:developer' as dev;

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
import 'package:flutter/material.dart';
import 'package:lexaglot/excercises/complete_translation/inline_textfield.dart';

class CompleteTranslationGame {
  String beforeTranslation = '';
  List<String> translationSplitted = [];
  String missingWord = '';
  List<String> validWords = [];
  List<String> textBefore = [];
  List<String> textAfter = [];
  late InlineTextfield textfield;

  bool isGameOver = false;
  bool isCorrect = false;

  CompleteTranslationGame(
    this.beforeTranslation,
    this.translationSplitted,
    this.missingWord,
    this.validWords,
  ) {
    processInput();
  }

  void processInput() {
    bool beforeWord = true;
    for (final word in translationSplitted) {
      if (word == missingWord) {
        beforeWord = false;
      } else if (beforeWord) {
        textBefore.add(word);
      } else {
        textAfter.add(word);
      }
      textfield = InlineTextfield(
        textBefore: textBefore.join(" "),
        textAfter: textAfter.join(" "),
        textfieldWidth: missingWord.length * 10,
      );
    }
  }

  void resetGame() {
    textfield.controller.clear();
    isGameOver = false;
    isCorrect = false;
  }

  void checkAns() {
    FocusManager.instance.primaryFocus?.unfocus();
    isGameOver = true;
    if (validWords.contains(textfield.controller.text)) {
      isCorrect = true;
    }
  }
}

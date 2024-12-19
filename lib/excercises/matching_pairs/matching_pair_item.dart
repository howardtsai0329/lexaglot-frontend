import 'package:flutter/material.dart';

enum ItemState { answered, notAnswered, wrong, correct }

class MatchingPairItem {
  final String word;
  final int code;
  ItemState state;

  MatchingPairItem(
    this.word,
    this.code, {
    this.state = ItemState.notAnswered,
  });

  Color get color {
    switch (state) {
      case ItemState.answered:
        return Colors.grey;
      case ItemState.notAnswered:
        return Colors.white;
      case ItemState.wrong:
        return Colors.red;
      case ItemState.correct:
        return Colors.green;
    }
  }
}

import 'package:flutter/material.dart';

enum ItemState { show, correct, wrong, hidden }

enum OnOff { active, inactive }

class TranslateSentenceItem {
  final String word;
  final int code;
  ItemState state;
  OnOff position;

  TranslateSentenceItem(
    this.word,
    this.code, {
    this.state = ItemState.show,
    this.position = OnOff.inactive,
  });

  Color get color {
    switch (state) {
      case ItemState.show || ItemState.hidden:
        return Colors.white;
      case ItemState.correct:
        return Colors.green;
      case ItemState.wrong:
        return Colors.red;
    }
  }
}

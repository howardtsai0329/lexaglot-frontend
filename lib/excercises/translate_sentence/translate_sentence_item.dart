import 'package:flutter/material.dart';

enum ItemState { show, correct, wrong, hidden }

class TranslateSentenceItem {
  final String word;
  ItemState state;

  TranslateSentenceItem(
    this.word, {
    this.state = ItemState.show,
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

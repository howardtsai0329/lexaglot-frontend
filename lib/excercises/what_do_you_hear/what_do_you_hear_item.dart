import 'package:flutter/material.dart';

enum ItemState { show, correct, wrong, selected }

class WhatDoYouHearItem {
  final String word;
  final bool isCorrect;
  ItemState state;

  WhatDoYouHearItem(
    this.word,
    this.isCorrect, {
    this.state = ItemState.show,
  });

  Color get color {
    switch (state) {
      case ItemState.show:
        return Colors.white;
      case ItemState.correct:
        return Colors.green;
      case ItemState.wrong:
        return Colors.red;
      case ItemState.selected:
        return Colors.lightGreen;
    }
  }
}

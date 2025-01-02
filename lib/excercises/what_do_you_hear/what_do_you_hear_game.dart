import 'package:lexaglot/excercises/what_do_you_hear/what_do_you_hear_item.dart';

class WhatDoYouHearGame {
  List<String> wrongChoice;
  String correctChoice;
  List<WhatDoYouHearItem> choice = [];
  bool isGameOver = false;
  bool isCorrect = false;

  WhatDoYouHearGame(
    this.wrongChoice,
    this.correctChoice,
  ) {
    isGameOver = false;
    _initializeItem();
  }

  void _initializeItem() {
    for (final word in wrongChoice) {
      choice.add(
        WhatDoYouHearItem(
          word,
          false,
        ),
      );
    }
    choice.add(
      WhatDoYouHearItem(
        correctChoice,
        true,
      ),
    );
    choice.shuffle();
  }

  void resetGame() {
    isGameOver = false;
    for (final item in choice) {
      item.state = ItemState.show;
    }
  }

  void onItemPressed(int index) {
    for (final item in choice) {
      item.state = ItemState.show;
    }
    choice[index].state = ItemState.selected;
  }

  void checkAns() {
    for (final item in choice) {
      if (item.state == ItemState.selected) {
        isGameOver = true;
        isCorrect = item.isCorrect;
        if (isCorrect) {
          item.state = ItemState.correct;
        } else {
          item.state = ItemState.wrong;
        }
      }
    }
  }
}

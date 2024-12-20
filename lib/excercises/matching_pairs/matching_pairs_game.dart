import 'package:lexaglot/excercises/matching_pairs/matching_pair_item.dart';
import 'dart:async';

class MatchingPairsGame {
  Map mockMatchingPairsInput;
  List<MatchingPairItem> matchingPairs = [];
  List<MatchingPairItem> leftMatchingPairs = [];
  List<MatchingPairItem> rightMatchingPairs = [];
  int code = 0;
  bool isGameOver = false;
  int answered = 0;

  MatchingPairsGame(this.mockMatchingPairsInput) {
    generatePairs();
  }

  void generatePairs() {
    matchingPairs = [];
    leftMatchingPairs = [];
    rightMatchingPairs = [];
    code = 0;
    for (final pairs in mockMatchingPairsInput.entries) {
      leftMatchingPairs.add(MatchingPairItem(pairs.key, code));
      rightMatchingPairs.add(MatchingPairItem(pairs.value, code));
      code++;
    }
    rightMatchingPairs.shuffle();
    for (int index in Iterable.generate(rightMatchingPairs.length)) {
      matchingPairs.add(leftMatchingPairs[index]);
      matchingPairs.add(rightMatchingPairs[index]);
    }
  }

  void resetGame() {
    generatePairs();
    isGameOver = false;
    answered = 0;
  }

  void onPairPressed(int index) {
    int? selectedPairsIndexes = _getSelectedPairIndexes();
    if (selectedPairsIndexes == null) {
      matchingPairs[index].state = ItemState.chosen;
    } else {
      MatchingPairItem pair1 = matchingPairs[selectedPairsIndexes];
      MatchingPairItem pair2 = matchingPairs[index];
      if (pair1.code == pair2.code) {
        pair1.state = ItemState.correct;
        pair2.state = ItemState.correct;
        answered += 1;
        Future.delayed(const Duration(milliseconds: 500), () {
          pair1.state = ItemState.answered;
          pair2.state = ItemState.answered;
          isGameOver = _isGameOver();
        });
      } else {
        pair1.state = ItemState.wrong;
        pair2.state = ItemState.wrong;
        Future.delayed(const Duration(milliseconds: 1000), () {
          pair1.state = ItemState.notAnswered;
          pair2.state = ItemState.notAnswered;
        });
      }
    }
  }

  int? _getSelectedPairIndexes() {
    for (int i = 0; i < matchingPairs.length; i++) {
      if (matchingPairs[i].state == ItemState.chosen) {
        return i;
      }
    }
    return null;
  }

  bool _isGameOver() {
    for (MatchingPairItem pairs in matchingPairs) {
      if (pairs.state == ItemState.notAnswered) {
        return false;
      }
    }
    return true;
  }
}

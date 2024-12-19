import 'package:lexaglot/excercises/matching_pairs/matching_pair_item.dart';
import 'dart:async';

class MatchingPairsGame {
  int time = 0;
  Map mockMatchingPairsInput;
  List<MatchingPairItem> matchingPairs = [];
  List<MatchingPairItem> rightMatchingPairs = [];
  int code = 0;
  bool isGameOver = false;

  MatchingPairsGame(this.mockMatchingPairsInput) {
    generatePairs();
  }

  void generatePairs() {
    matchingPairs = [];
    rightMatchingPairs = [];
    code = 0;
    for (final pairs in mockMatchingPairsInput.entries) {
      matchingPairs.add(MatchingPairItem(pairs.key, code));
      rightMatchingPairs.add(MatchingPairItem(pairs.value, code));
      code++;
    }
    rightMatchingPairs.shuffle();
    matchingPairs += rightMatchingPairs;
  }

  void resetGame() {
    generatePairs();
    isGameOver = false;
  }

  void onPairPressed(int index) {
    int? selectedPairsIndexes = _getSelectedPairIndexes();
    if (selectedPairsIndexes == null) {
      matchingPairs[index].state = ItemState.correct;
    } else {
      MatchingPairItem pair1 = matchingPairs[selectedPairsIndexes];
      MatchingPairItem pair2 = matchingPairs[index];
      if (pair1.code == pair2.code) {
        pair2.state = ItemState.correct;
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
      if (matchingPairs[i].state == ItemState.correct) {
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

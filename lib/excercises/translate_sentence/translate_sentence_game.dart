import 'package:lexaglot/excercises/translate_sentence/translate_sentence_item.dart';

class TranslateSentenceGame {
  String beforeTranslation = '';
  List<String> correctTranslations = [];
  List<String> words = [];
  List<TranslateSentenceItem> options = [];
  List<TranslateSentenceItem> actives = [];

  bool isGameOver = false;
  int answered = 0;

  TranslateSentenceGame(
    this.correctTranslations,
    this.words,
    this.beforeTranslation,
  ) {
    generateOptions();
  }

  void generateOptions() {
    options = [];
    for (final word in words) {
      options.add(TranslateSentenceItem(word));
    }
    options.shuffle();
  }

  void resetGame() {
    generateOptions();
    actives = [];
    isGameOver = false;
  }

  void onShowPressed(TranslateSentenceItem item) {
    actives.add(item);
    item.state = ItemState.hidden;
  }

  void onActivePressed(TranslateSentenceItem item) {
    actives.remove(item);
    item.state = ItemState.show;
  }

  void checkAns() {
    List ans = [];
    for (final active in actives) {
      ans.add(active.word);
    }
    String joined = ans.join(' ');
    if (correctTranslations.contains(joined)) {
      isGameOver = true;
      for (final active in actives) {
        active.state = ItemState.correct;
      }
    } else {
      for (final active in actives) {
        active.state = ItemState.wrong;
      }
      Future.delayed(const Duration(milliseconds: 1000), () {
        for (final active in actives) {
          active.state = ItemState.hidden;
        }
      });
    }
  }
}

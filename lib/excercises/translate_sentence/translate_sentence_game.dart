import 'package:lexaglot/excercises/translate_sentence/translate_sentence_item.dart';

class TranslateSentenceGame {
  String beforeTranslation = '';
  List<String> correctTranslations = [];
  List<String> words = [];
  List<TranslateSentenceItem> options = [];
  List<TranslateSentenceItem> actives = [];

  int code = 0;
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
    code = 0;
    for (final word in words) {
      options.add(TranslateSentenceItem(word, code));
      code++;
    }
    options.shuffle();
  }

  void resetGame() {
    generateOptions();
    actives = [];
    isGameOver = false;
  }

  void onShowPressed(int code) {
    for (final option in options) {
      if (option.code == code) {
        actives.add(option);
        option.state = ItemState.hidden;
        break;
      }
    }
  }

  void onActivePressed(int code) {
    for (final active in actives) {
      if (active.code == code) {
        actives.remove(active);
        active.state = ItemState.show;
        break;
      }
    }
  }

  void checkAns() {
    List ans = [];
    for (final active in actives) {
      ans.add(active.word);
    }
    String joined = ans.join(' ');
    for (final translation in correctTranslations) {
      if (joined == translation) {
        isGameOver = true;
        for (final active in actives) {
          active.state = ItemState.correct;
        }
      }
    }
    if (!isGameOver) {
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

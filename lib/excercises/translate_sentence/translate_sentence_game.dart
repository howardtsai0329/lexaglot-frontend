import 'package:lexaglot/excercises/translate_sentence/translate_sentence_item.dart';

class TranslateSentenceGame {
  String beforeTranslation = '';
  List<String> correctTranslation = [];
  List<String> wrongWords = [];
  List<TranslateSentenceItem> options = [];
  List<TranslateSentenceItem> actives = [];

  int code = 0;
  bool isGameOver = false;
  int answered = 0;

  TranslateSentenceGame(
    this.correctTranslation,
    this.wrongWords,
    this.beforeTranslation,
  ) {
    generateOptions();
  }

  void generateOptions() {
    options = [];
    code = 0;
    for (final word in correctTranslation) {
      options.add(TranslateSentenceItem(word, code));
      code++;
    }
    for (final word in wrongWords) {
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
}

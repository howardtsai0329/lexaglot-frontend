import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lexaglot/excercises/complete_translation/complete_translation_view.dart';
import 'package:lexaglot/excercises/general/colored_button.dart.dart';
import 'package:lexaglot/excercises/translate_sentence/translate_sentence_button.dart';
import 'package:lexaglot/excercises/translate_sentence/translate_sentence_game.dart';
import 'package:lexaglot/excercises/translate_sentence/translate_sentence_item.dart';
import 'package:lexaglot/mock_inputs/mock_translate_sentence.dart';

class TranslateSentenceView extends StatefulWidget {
  const TranslateSentenceView({super.key});

  @override
  State<TranslateSentenceView> createState() => _TranslateSentenceViewState();
}

class _TranslateSentenceViewState extends State<TranslateSentenceView> {
  late TranslateSentenceGame game;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    game = TranslateSentenceGame(
      correctTranslations,
      words,
      sentenceBeforeTranslation,
    );
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(microseconds: 100), (t) {
      setState(() {});
      if (game.isGameOver) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _resetGame() {
    game.resetGame();
    setState(() {
      timer.cancel();
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translate Sentence'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 10,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Image.asset('assets/images/Shiro_Anime_HQ.webp'),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    const Expanded(
                      flex: 6,
                      child: Text(
                        sentenceBeforeTranslation,
                        style: TextStyle(fontSize: 25),
                      ),
                    )
                  ],
                )),
            Expanded(
              flex: 7,
              child: Wrap(
                children: List.generate(game.actives.length, (index) {
                  return TranslateSentenceButton(
                    translateSentenceItem: game.actives[index],
                    onPressed: game.onActivePressed,
                    isActive: true,
                  );
                }),
              ),
            ),
            Expanded(
              flex: 7,
              child: Align(
                child: Wrap(
                  children: List.generate(game.options.length, (index) {
                    return TranslateSentenceButton(
                      translateSentenceItem: game.options[index],
                      onPressed: game.onShowPressed,
                      isActive: game.options[index].state == ItemState.show,
                    );
                  }),
                ),
              ),
            ),
            if (game.isGameOver)
              Expanded(
                flex: 4,
                child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 7,
                  children: [
                    ColoredButton(
                      title: 'Play Again',
                      onPressed: () => _resetGame(),
                      backgroundColor: Colors.amberAccent[700],
                      textColor: Colors.black,
                    ),
                    ColoredButton(
                      title: 'Next Exercise',
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const CompleteTranslationView();
                        }),
                      ),
                      backgroundColor: Colors.green,
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
            if (!game.isGameOver)
              const Expanded(
                child: SizedBox(),
              ),
            if (!game.isGameOver)
              Expanded(
                flex: 2,
                child: ColoredButton(
                  title: 'Check Answers',
                  onPressed: () => game.checkAns(),
                  backgroundColor: Colors.green,
                  textColor: Colors.black,
                ),
              ),
            if (!game.isGameOver)
              const Expanded(
                child: SizedBox(),
              ),
          ],
        ),
      ),
    );
  }
}

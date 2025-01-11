import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lexaglot/excercises/complete_translation/complete_translation_view.dart';
import 'package:lexaglot/excercises/general/colored_button.dart';
import 'package:lexaglot/excercises/translate_sentence/translate_sentence_button.dart';
import 'package:lexaglot/excercises/translate_sentence/translate_sentence_game.dart';
import 'package:lexaglot/excercises/translate_sentence/translate_sentence_item.dart';

class TranslateSentenceView extends StatefulWidget {
  final List<String> correctTranslations;
  final List<String> words;
  final String sentenceBeforeTranslation;

  const TranslateSentenceView({
    super.key,
    required this.correctTranslations,
    required this.words,
    required this.sentenceBeforeTranslation,
  });

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
      widget.correctTranslations,
      widget.words,
      widget.sentenceBeforeTranslation,
    );
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
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
                    Expanded(
                      flex: 6,
                      child: Text(
                        game.beforeTranslation,
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
                      gradientColors: [
                        Colors.blue.shade500,
                        Colors.teal.shade400,
                      ],
                      textColor: Colors.black,
                    ),
                    ColoredButton(
                      title: 'Next Exercise',
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const CompleteTranslationView();
                        }),
                      ),
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

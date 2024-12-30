import 'package:flutter/material.dart';
import 'package:lexaglot/excercises/complete_translation/complete_translation_game.dart';
import 'package:lexaglot/excercises/general/colored_button.dart.dart';
import 'package:lexaglot/excercises/general/correct_answer_banner.dart';
import 'package:lexaglot/excercises/general/wrong_answer_banner.dart';
import 'package:lexaglot/mock_inputs/mock_complete_translation.dart';

class CompleteTranslationView extends StatefulWidget {
  const CompleteTranslationView({super.key});

  @override
  State<CompleteTranslationView> createState() =>
      _CompleteTranslationViewState();
}

class _CompleteTranslationViewState extends State<CompleteTranslationView> {
  late CompleteTranslationGame game;

  @override
  void initState() {
    super.initState();
    game = CompleteTranslationGame(
      sentenceBeforeTranslation,
      translationSplitted,
      missingWord,
      validWords,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _checkAnswers() {
    setState(() {
      game.checkAns();
    });
  }

  void _resetGame() {
    setState(() {
      game.resetGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Translation'),
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
              ),
            ),
            Expanded(
              flex: 14,
              child: game.textfield,
            ),
            if (game.isGameOver && game.isCorrect)
              Expanded(
                flex: 4,
                child: CorrectAnswerBanner(
                  message: 'You are correct',
                  button: ColoredButton(
                      title: 'Continue',
                      onPressed: () {},
                      textColor: Colors.black),
                ),
              ),
            if (game.isGameOver && !game.isCorrect)
              Expanded(
                flex: 4,
                child: WrongAnswerBanner(
                  message: 'You are wrong',
                  button: ColoredButton(
                      title: 'Try again',
                      onPressed: () => _resetGame(),
                      gradientColors: [
                        Colors.red.shade400,
                        Colors.red.shade700,
                      ],
                      textColor: Colors.black),
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
                  onPressed: () => _checkAnswers(),
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

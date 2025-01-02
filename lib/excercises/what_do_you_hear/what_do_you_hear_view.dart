import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lexaglot/excercises/general/colored_button.dart';
import 'package:lexaglot/excercises/general/correct_answer_banner.dart';
import 'package:lexaglot/excercises/general/wrong_answer_banner.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_view.dart';
import 'package:lexaglot/excercises/what_do_you_hear/mutiple_choice_button.dart';
import 'package:lexaglot/excercises/what_do_you_hear/what_do_you_hear_game.dart';
import 'package:lexaglot/mock_inputs/mock_what_do_you_hear.dart';

class WhatDoYouHearView extends StatefulWidget {
  const WhatDoYouHearView({super.key});

  @override
  State<WhatDoYouHearView> createState() => _WhatDoYouHearViewState();
}

class _WhatDoYouHearViewState extends State<WhatDoYouHearView> {
  late Timer timer;
  late AudioPlayer _audioPlayer;
  late WhatDoYouHearGame game;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    game = WhatDoYouHearGame(
      wrongChoice,
      correctChoice,
    );
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 1000), (t) {
      setState(() {});
      if (game.isGameOver) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    timer.cancel();
    super.dispose();
  }

  void _checkAnswers() {
    setState(() {
      game.checkAns();
    });
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
        title: const Text('What do you hear'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Image.asset(
                      'assets/images/Megumin.png',
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: IconButton(
                      onPressed: () async {
                        try {
                          await _audioPlayer
                              .play(AssetSource('audios/explosion.mp3'));
                        } catch (e) {
                          print('Error playing sound: $e');
                        }
                      },
                      icon: const Icon(
                        Icons.volume_up,
                        size: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 14,
              child: ListView.builder(
                itemCount: game.choice.length,
                itemBuilder: (context, index) {
                  return MutipleChoiceButton(
                    onItemPressed: game.onItemPressed,
                    item: game.choice[index],
                    index: index,
                  );
                },
              ),
            ),
            if (game.isGameOver && game.isCorrect)
              Expanded(
                flex: 4,
                child: CorrectAnswerBanner(
                  message: 'You are correct',
                  button: ColoredButton(
                      title: 'Continue',
                      onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const MatchingPairsView();
                            }),
                          ),
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

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lexaglot/excercises/general/colored_button.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_button.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_data.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_game.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MatchingPairsView extends StatefulWidget {
  final VoidCallback onNext;
  final MatchingPairsData data;
  const MatchingPairsView({
    super.key,
    required this.data,
    required this.onNext,
  });

  @override
  State<MatchingPairsView> createState() => _MatchingPairsViewState();
}

class _MatchingPairsViewState extends State<MatchingPairsView> {
  late MatchingPairsGame game;
  late Timer timer;
  late int total;

  @override
  void initState() {
    super.initState();
    game = MatchingPairsGame(widget.data.pairs);
    total = widget.data.pairs.length;
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
        title: const Text('Matching Pairs'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: LinearPercentIndicator(
                lineHeight: 14.0,
                percent: game.answered / total,
                backgroundColor: Colors.grey,
                progressColor: Colors.lightGreen,
              ),
            ),
            Expanded(
              flex: 10,
              child: GridView.count(
                crossAxisCount: total ~/ 2,
                childAspectRatio: 3,
                mainAxisSpacing: 30,
                crossAxisSpacing: 10,
                children: List.generate(game.matchingPairs.length, (index) {
                  return MatchingPairsButton(
                    matchingPairItem: game.matchingPairs[index],
                    onItemPressed: game.onPairPressed,
                    index: index,
                  );
                }),
              ),
            ),
            if (game.isGameOver)
              Expanded(
                flex: 2,
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
                      onPressed: widget.onNext,
                      textColor: Colors.black,
                    ),
                  ],
                ),
              )
            else
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
          ],
        ),
      ),
    );
  }
}

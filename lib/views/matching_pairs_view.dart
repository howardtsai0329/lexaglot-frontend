import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_buttons.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_card.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_game.dart';
import 'package:lexaglot/mock_inputs/mock_matching_pairs.dart';

class MatchingPairsView extends StatefulWidget {
  const MatchingPairsView({super.key});

  @override
  State<MatchingPairsView> createState() => _MatchingPairsViewState();
}

class _MatchingPairsViewState extends State<MatchingPairsView> {
  MatchingPairsGame? game;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    game = MatchingPairsGame(mockMatchingPairsInput);
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(microseconds: 100), (t) {
      setState(() {});
    });
  }

  void _resetGame() {
    game!.resetGame();
    setState(() {});
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
              flex: 5,
              child: GridView.count(
                crossAxisCount: mockMatchingPairsInput.length ~/ 2,
                children: List.generate(game!.matchingPairs.length, (index) {
                  return MatchingPairsCard(
                    matchingPairItem: game!.matchingPairs[index],
                    onItemPressed: game!.onPairPressed,
                    index: index,
                  );
                }),
              ),
            ),
            if (game!.isGameOver)
              Expanded(
                flex: 1,
                child: MatchingButtons(
                  title: 'Try Again',
                  onPressed: () => _resetGame(),
                ),
              )
            else
              const Expanded(
                flex: 1,
                child: SizedBox(),
              )
          ],
        ),
      ),
    );
  }
}

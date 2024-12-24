import 'package:flutter/material.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_item.dart';

class MatchingPairsButton extends StatelessWidget {
  final MatchingPairItem matchingPairItem;
  final Function(int) onItemPressed;
  final int index;
  const MatchingPairsButton(
      {super.key,
      required this.matchingPairItem,
      required this.onItemPressed,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (matchingPairItem.state == ItemState.notAnswered) {
          onItemPressed(index);
        }
      },
      child: Card(
        margin: const EdgeInsets.all(4),
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: matchingPairItem.color,
        child: Center(
          child: Text(
            matchingPairItem.word,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

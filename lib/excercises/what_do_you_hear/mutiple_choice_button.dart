import 'package:flutter/material.dart';
import 'package:lexaglot/excercises/what_do_you_hear/what_do_you_hear_item.dart';

class MutipleChoiceButton extends StatelessWidget {
  final Function(int) onItemPressed;
  final WhatDoYouHearItem item;
  final int index;
  const MutipleChoiceButton({
    super.key,
    required this.onItemPressed,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemPressed(index);
      },
      child: Card(
        color: item.color,
        margin: const EdgeInsets.all(10),
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              item.word,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

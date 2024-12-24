import 'package:flutter/material.dart';
import 'package:lexaglot/excercises/translate_sentence/translate_sentence_item.dart';

class TranslateSentenceButton extends StatelessWidget {
  final TranslateSentenceItem translateSentenceItem;
  final Function(TranslateSentenceItem) onPressed;
  final bool isActive;
  const TranslateSentenceButton({
    super.key,
    required this.translateSentenceItem,
    required this.onPressed,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: translateSentenceItem.color,
        textStyle: const TextStyle(fontSize: 18),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
      ),
      onPressed: isActive ? () => onPressed(translateSentenceItem) : null,
      child: Text(
        translateSentenceItem.word,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

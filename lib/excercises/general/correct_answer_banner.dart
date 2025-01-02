import 'package:flutter/material.dart';
import 'package:lexaglot/excercises/general/colored_button.dart';

class CorrectAnswerBanner extends StatelessWidget {
  const CorrectAnswerBanner({
    super.key,
    required this.message,
    required this.button,
  });

  final String message;
  final ColoredButton button;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: <Widget>[
              const Expanded(
                flex: 3,
                child: Icon(
                  Icons.check_box,
                  color: Colors.green,
                  size: 35,
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 25, color: Colors.green),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: button,
        ),
      ],
    );
  }
}

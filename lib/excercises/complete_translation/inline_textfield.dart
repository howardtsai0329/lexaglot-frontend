import 'package:flutter/material.dart';

class InlineTextfield extends StatefulWidget {
  InlineTextfield(
      {required this.textBefore,
      required this.textAfter,
      required this.textfieldWidth,
      super.key,
      required});

  final String textBefore;
  final String textAfter;
  final double textfieldWidth;
  final TextEditingController controller = TextEditingController();

  @override
  State<InlineTextfield> createState() => _InlineTextfieldState();
}

class _InlineTextfieldState extends State<InlineTextfield> {
  bool enable = true;
  void toggle() {
    enable = !enable;
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <InlineSpan>[
          // first part
          WidgetSpan(
            child: Text(
              "${widget.textBefore}  ",
              style: const TextStyle(fontSize: 18),
            ),
          ),
          // flexible text field
          WidgetSpan(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: widget.textfieldWidth),
              child: IntrinsicWidth(
                child: TextField(
                  enabled: enable,
                  autofocus: true,
                  controller: widget.controller,
                  maxLines: null,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(0),
                  ),
                ),
              ),
            ),
          ),
          WidgetSpan(
            child: Text(
              "  ${widget.textAfter}",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

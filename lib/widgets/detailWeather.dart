import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Content extends StatelessWidget {
  String text;
  String content;

  Content({Key key, this.text, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: content,
        style: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 13,
        ),
        children: <TextSpan>[
          TextSpan(
              text: '  $text\n',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.white,
                fontSize: 17,
              ),
              recognizer: TapGestureRecognizer()),
        ],
      ),
    );
  }
}

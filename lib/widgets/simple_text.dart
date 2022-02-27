import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  final double fontSize, topMargin;
  final String text;
  final Color textColor;
  final FontWeight weight;
  final TextAlign align;
  final double letterSpacing;

  // ignore: use_key_in_widget_constructors
  const SimpleText(this.text,
      {this.fontSize = 22,
      this.topMargin = 33,
      this.textColor = Colors.black,
      this.weight = FontWeight.w600,
      this.align = TextAlign.center,
      this.letterSpacing = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      width: double.infinity,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: weight,
            letterSpacing: letterSpacing),
      ),
    );
  }
}

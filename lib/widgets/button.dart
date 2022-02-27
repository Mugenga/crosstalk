import 'package:crosstalk/helpers/constants.dart';
import 'package:crosstalk/widgets/simple_text.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Color color;
  final double marginTop, width, height, fontSize;
  final FontWeight weight;

  // ignore: use_key_in_widget_constructors
  const Button(this.buttonText,
      {this.color = kprimaryColor,
      this.marginTop = 0,
      this.height = 45,
      this.width = 298,
      this.fontSize = 18,
      this.weight = FontWeight.w700});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(top: marginTop),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        child: Center(
          child: SimpleText(
            buttonText,
            fontSize: fontSize,
            weight: weight,
            textColor: kBackground,
            topMargin: 0,
          ),
        ));
  }
}

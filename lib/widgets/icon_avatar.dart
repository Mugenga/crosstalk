import 'package:crosstalk/helpers/constants.dart';
import 'package:flutter/material.dart';

class IconAvatar extends StatelessWidget {
  final Color color, background;
  final double width, height, iconSize;
  final IconData icon;

  // ignore: use_key_in_widget_constructors
  const IconAvatar(
      {this.width = 41,
      this.height = 41,
      this.color = Colors.white,
      this.icon = Icons.play_arrow,
      this.iconSize = 30,
      this.background = const Color(0xffE56B70)});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.all(
          Radius.circular(height / 2),
        ),
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: color,
      ),
      // child: WebsafeSvg.asset(
      //   iconPath,
      //   color: color,
      // ),
    );
  }
}

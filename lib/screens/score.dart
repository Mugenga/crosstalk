import 'package:crosstalk/helpers/constants.dart';
import 'package:crosstalk/screens/pronounce_screen.dart';
import 'package:crosstalk/widgets/button.dart';
import 'package:crosstalk/widgets/simple_text.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ScoreScreen extends StatelessWidget {
  static const routeName = '/score';

  navigateToDashboard(ctx) =>
      Navigator.of(ctx).pushNamed(PronounceScreen.routeName);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final score = double.parse(routeArgs['score'].toString());
    var circleHeight = screenHeight / 5.6;
    return Scaffold(
      appBar: AppBar(
        title: Text('Resuts'),
      ),
      backgroundColor: kBackground,
      body: Column(
        children: [
          Container(
            height: circleHeight,
            width: circleHeight,
            margin: EdgeInsets.only(top: screenHeight / 4.4),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const CircularProgressIndicator(
                  value: 0.6,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                  backgroundColor: Colors.black87,
                  strokeWidth: 8,
                ),
                Center(
                  child: Container(
                    height: circleHeight,
                    width: circleHeight,
                    decoration: BoxDecoration(
                      color: score < 50 ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(circleHeight / 2),
                      // border: Border.all(
                      //   color: kPrimaryColor,
                      //   width: 5,
                      // ),
                      // image: DecorationImage(
                      //   fit: BoxFit.fill,
                      //   image: NetworkImage(
                      //       tripInfo["rider"]["photo"]),
                      // ),
                    ),
                    child: Center(
                      child: Text(
                        '$score %',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenHeight / 27),
          const SimpleText(
            'Your score',
            fontSize: 26,
            topMargin: 5,
          ),
          SizedBox(height: screenHeight / 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'TRY AGAIN',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'NEXT QUESTION',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

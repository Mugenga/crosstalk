import 'dart:async';
import 'dart:typed_data';

import 'package:crosstalk/helpers/constants.dart';
import 'package:crosstalk/screens/home_screen.dart';
import 'package:crosstalk/widgets/simple_text.dart';
import 'package:flutter/material.dart';
// import 'package:map/screens/finding_driver_screen.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class GetStartedScreen extends StatefulWidget {
  static const routName = '/getStarted';

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  Future<void> _start() async {
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  }

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3),
        () => Navigator.of(context).pushNamed(HomeScreen.routeName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Provider.of<AppContext>(context, listen: false)
    //     .setScreenDimensions(size.width, size.height);
    final screenWidth = size.width;
    final screenHeight = size.height;
    return Scaffold(
      backgroundColor: Color(0xffEAF4F7),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 0.9 * screenWidth,
                  width: 0.9 * screenWidth,
                  margin: EdgeInsets.only(top: 50),
                  child: Image.asset('assets/images/kaze.png',
                      fit: BoxFit.contain),
                ),
              ],
            ),
          ),
          Expanded(
              child: ClipPath(
            clipper: MyClipper(),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kBackground,
                borderRadius: BorderRadius.only(),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 6.8,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(296, 50)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kBackground),
                      elevation: MaterialStateProperty.all<double>(0),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    child: const Center(
                      child: SimpleText(
                        'Learn Speaking Kinyarwanda',
                        weight: FontWeight.w700,
                        textColor: Colors.black,
                        fontSize: 18,
                        topMargin: 0,
                      ),
                    ),
                    onPressed: _start,
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height * 0.3);
    var controllPoint = Offset(size.width / 5, size.height * 0.01);
    var endpoint = Offset(size.width / 2, 0);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endpoint.dx, endpoint.dy);

    controllPoint = Offset(size.width - (size.width / 5), size.height * 0.01);
    endpoint = Offset(size.width, size.height * 0.3);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endpoint.dx, endpoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

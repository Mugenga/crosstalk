import 'package:crosstalk/provider/words.dart';
import 'package:crosstalk/screens/get_started.dart';
import 'package:crosstalk/screens/home_screen.dart';
import 'package:crosstalk/screens/pronounce_screen.dart';
import 'package:crosstalk/screens/score.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Words(),
        ),
      ],
      child: MaterialApp(
        title: 'Kaze',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amber),
        ),
        home: GetStartedScreen(),
        routes: {
          GetStartedScreen.routName: (ctx) => GetStartedScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          PronounceScreen.routeName: (ctx) => const PronounceScreen(),
          ScoreScreen.routeName: (ctx) => ScoreScreen(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nicamal_app/ui/SplashScreen.dart';

import 'ui/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nicamal',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => SplashScreen(),
        '/home': (BuildContext context) => HomePage()
      }
    );
  }
}



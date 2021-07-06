import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nicamal_app/ui/detail_screen.dart';
import 'package:nicamal_app/ui/splash_screen.dart';
import 'package:flutter/services.dart';

import 'ui/home_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light
  ));
  
  HttpOverrides.global = new MyHttpOverrides();
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
        '/home': (BuildContext context) => HomePage(),
        '/publication/detail': (BuildContext context) => DetailScreen()
      }
    );
  }
}



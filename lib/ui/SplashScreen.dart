import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/io/FileManager.dart';
import 'package:nicamal_app/io/Services.dart';
import 'package:nicamal_app/ui/HomeScreen.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  Artboard _riveArtboard;
  RiveAnimationController _riveAnimationController;
  FileManager manager = FileManager();
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greyBackground = Color.fromARGB(255, 245, 245, 245);

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/nicamal_splashscreen_2.riv').then((value) async {
      final file = RiveFile.import(value);
      final artboard = file.mainArtboard;

      artboard.addController(
          _riveAnimationController = SimpleAnimation('main'));
      setState(() => _riveArtboard = artboard);
    });


    Timer(Duration(milliseconds: 2500), () async {
      Navigator.push(context, PageRouteBuilder(
          pageBuilder: (c, a1, a2) => HomePage(),
        transitionDuration: Duration(milliseconds: 1600),
        transitionsBuilder: (context, animation, animation2, child) => FadeTransition(opacity: animation, child: child)
      )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: greyBackground,
        body: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              child: _riveArtboard == null
                  ? const SizedBox()
                  : Rive(artboard: _riveArtboard, fit: BoxFit.cover,),
            ),
          ],
      )
    );
  }
}

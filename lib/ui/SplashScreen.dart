import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  Artboard _riveArtboard;
  RiveAnimationController _riveAnimationController;

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/nicamal_splashscreen.riv').then((value) async {
      final file = RiveFile.import(value);
      final artboard = file.mainArtboard;

      artboard.addController(
          _riveAnimationController = SimpleAnimation('Animation 1'));
      setState(() => _riveArtboard = artboard);
    });

    Timer(Duration(seconds: 6), () => Navigator.pushNamed(context, '/home'));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      child: _riveArtboard == null
          ? const SizedBox()
          : Rive(artboard: _riveArtboard),
    ));
  }
}

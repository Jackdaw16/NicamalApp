import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class CustomProgressIndicatorComponent extends StatefulWidget {

  @override
  _CustomProgressIndicatorComponent createState() => _CustomProgressIndicatorComponent();

}

class _CustomProgressIndicatorComponent extends State<CustomProgressIndicatorComponent> {

  Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    rootBundle.load('assets/nicamal-progressindicator.riv').then(
            (value) async {
          final file = RiveFile.import(value);

          final artboard = file.mainArtboard;

          artboard.addController(_controller = SimpleAnimation('Animation 1'));
          setState(() => _riveArtboard = artboard);

        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container (
      height: 200,
      width: 200,
      child: _riveArtboard == null
          ? const SizedBox()
          : Rive(artboard: _riveArtboard),
    );
  }

}
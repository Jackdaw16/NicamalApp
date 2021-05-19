import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SpashScreen extends StatefulWidget {

  @override
  _SpashScreen createState() => _SpashScreen();
}

class _SpashScreen extends State<SpashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
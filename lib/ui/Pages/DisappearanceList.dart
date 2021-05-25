import 'package:flutter/material.dart';

class DisappearanceList extends StatefulWidget {
  @override
  _DisappearanceListState createState() => _DisappearanceListState();
}

class _DisappearanceListState extends State<DisappearanceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover
            )
        ),
        child: Text('DisappearanceList'),
      ),
    );
  }
}
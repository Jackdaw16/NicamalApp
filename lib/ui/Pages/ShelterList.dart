import 'package:flutter/material.dart';

class ShelterList extends StatefulWidget {
  @override
  _ShelterListState createState() => _ShelterListState();
}

class _ShelterListState extends State<ShelterList> {
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
        child: Text('ShelterList'),
      ),
    );
  }
}
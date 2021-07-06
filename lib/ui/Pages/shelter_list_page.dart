import 'package:flutter/material.dart';
import 'package:nicamal_app/components/list_of_shelters_component.dart';

class ShelterList extends StatefulWidget {
  @override
  _ShelterListState createState() => _ShelterListState();
}

class _ShelterListState extends State<ShelterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListOfShelters()
        ],
      )
    );
  }
}
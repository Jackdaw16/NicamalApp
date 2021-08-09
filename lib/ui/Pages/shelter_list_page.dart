import 'package:flutter/material.dart';
import 'package:nicamal_app/components/list_of_shelters_component.dart';

class ShelterListPage extends StatefulWidget {
  @override
  _ShelterListPageState createState() => _ShelterListPageState();
}

class _ShelterListPageState extends State<ShelterListPage> {
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
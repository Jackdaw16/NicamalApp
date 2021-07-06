import 'package:flutter/material.dart';
import 'package:nicamal_app/components/list_of_adopts_component.dart';

class AdopList extends StatefulWidget {
  @override
  _AdopListState createState() => _AdopListState();
}

class _AdopListState extends State<AdopList> {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);
  final Color greyBackground = Color.fromARGB(255, 245, 245, 245);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBackground,
      body: Column (
        children: [
          ListOfAdoptsComponent()
        ],
      )
    );
  }
}



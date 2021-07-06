import 'package:flutter/material.dart';
import 'package:nicamal_app/components/list_disappearances_component.dart';

class DisappearanceList extends StatefulWidget {
  @override
  _DisappearanceListState createState() => _DisappearanceListState();
}

class _DisappearanceListState extends State<DisappearanceList> {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);
  final Color greyBackground = Color.fromARGB(255, 245, 245, 245);
  @override
  bool safeArea (double padding) {
    if (padding > 0) {
      return true;
    }

    return false;
  }
  
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: greyBackground,
      body: SafeArea(
        top: safeArea(padding),
          child: Column(
            children: [
              ListDisappearancesComponent()
            ],
          ),
      )
    );
  }
}
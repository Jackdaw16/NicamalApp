import 'package:flutter/material.dart';
import 'package:nicamal_app/components/list_of_adopts_component.dart';

class AdoptList extends StatefulWidget {
  final String shelterId;
  final bool isUrgent;

  const AdoptList({Key key, this.shelterId, this.isUrgent}) : super(key: key);

  @override
  _AdoptListState createState() => _AdoptListState();
}

class _AdoptListState extends State<AdoptList> {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);
  final Color greyBackground = Color.fromARGB(255, 245, 245, 245);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBackground,
      body: Column (
        children: [
          if(widget.shelterId != null)
            ListOfAdoptsComponent(shelterId: widget.shelterId, isUrgent: widget.isUrgent),

          if(widget.shelterId == null)
            ListOfAdoptsComponent()
        ],
      )
    );
  }
}



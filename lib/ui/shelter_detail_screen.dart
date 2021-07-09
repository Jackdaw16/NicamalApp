import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/custom_progress_indicator_component.dart';
import 'package:nicamal_app/components/warning_messagge.dart';
import 'package:nicamal_app/io/services.dart';
import 'package:nicamal_app/models/viewModels/shelter_view_model.dart';

class ShelterDetailScreen extends StatefulWidget {
  final String id;
  const ShelterDetailScreen({Key key, this.id}) : super(key: key);

  @override
  _ShelterDetailScreenState createState() => _ShelterDetailScreenState();
}

class _ShelterDetailScreenState extends State<ShelterDetailScreen> {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greyBackground = Color.fromARGB(255, 245, 245, 245);
  Services services = Services();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: greyBackground,
      body: FutureBuilder<UserShelterDetail> (
        future: services.getShelter(widget.id),
        builder: (BuildContext context, AsyncSnapshot<UserShelterDetail> snapshot){
          List<Widget> children;
          if (snapshot.hasData){
            children = <Widget>[
              
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              Container(
                width: double.infinity,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    informationWarning(
                        greenPrimary, snapshot.error.toString()),
                    TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text('Reset',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: greenPrimary)),
                    ),
                  ],
                ),
              )
            ];
          } else {
            children = <Widget>[
              Container(
                width: double.infinity,
                height: height,
                child: Center(
                  child: CustomProgressIndicatorComponent(),
                ),
              )
            ];
          }

          return Column(
            children: children,
          );
        },
      ),
    );
  }
}

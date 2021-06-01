import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nicamal_app/components/CustomProgressIndicatorComponent.dart';
import 'package:nicamal_app/components/DescriptionCard.dart';
import 'package:nicamal_app/components/ImageDialog.dart';
import 'package:nicamal_app/components/PopUpMenu.dart';
import 'package:nicamal_app/components/SecondDescriptionCard.dart';
import 'package:nicamal_app/components/WarningMessagge.dart';
import 'package:nicamal_app/io/Services.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({Key key, this.id}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greyBackground = Color.fromARGB(255, 245, 245, 245);
  Services services = Services();

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: greyBackground,
      body: FutureBuilder<PublicationDetail>(
          future: services.getPublication(widget.id),
          builder: (BuildContext context,
              AsyncSnapshot<PublicationDetail> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                Column(
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: 'image' + widget.id.toString(),
                          child: Container(
                            width: double.infinity,
                            height: height * 0.5,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(snapshot.data.image),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(100))),
                            child: GestureDetector(
                              onTap: () async {
                                await showGeneralDialog(
                                    transitionBuilder:
                                        (context, a1, a2, widget) {
                                      return Transform.scale(
                                        scale: a1.value,
                                        child: Opacity(
                                            opacity: a1.value,
                                            child: ImageDialog(
                                                urlImage: snapshot.data.image
                                                    .toString())),
                                      );
                                    },
                                    transitionDuration:
                                        Duration(milliseconds: 200),
                                    context: context,
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    barrierDismissible: true,
                                    barrierLabel: '',
                                    pageBuilder:
                                        (context, animation1, animation2) {});
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 48, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromRGBO(254, 254, 254, 0.4),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    icon: Icon(Icons.arrow_back),
                                    color: Colors.green),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromRGBO(254, 254, 254, 0.4),
                                child: popUpMenu(context, Colors.green),
                              )
                            ],
                          ),
                        ),
                        DescriptionCard(
                            context,
                            snapshot.data.name.toString(),
                            snapshot.data.species.toString(),
                            snapshot.data.weight.toString(),
                            '1 año',
                            snapshot.data.gender.toString(),
                            snapshot.data.user.country.toString() +
                                ', ' +
                                snapshot.data.user.province.toString()),
                      ],
                    ),

                    SecondDescriptionCard(
                        context,
                        snapshot.data.user.image.toString(),
                        snapshot.data.user.name.toString(),
                        snapshot.data.updatedAt.toString(),
                        snapshot.data.history.toString(),
                        snapshot.data.personality.toString(),
                        snapshot.data.observation.toString())

                  ],
                ),
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
                                fontFamily: 'Quicksand', color: greenPrimary)),
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

            return SingleChildScrollView(
              child: Column(
                children: children,
              ),
            );
          }),
    );
  }
}

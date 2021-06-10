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
import 'package:nicamal_app/models/viewModels/DisappearanceViewModel.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  final bool isMissing;

  const DetailScreen({Key key, this.id, this.isMissing}) : super(key: key);

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
      body: SingleChildScrollView (
        child: Column (
          children: [
            if(!widget.isMissing)
              FutureBuilder<PublicationDetail>(
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
                                    name: snapshot.data.name.toString(),
                                    specie: snapshot.data.species.toString(),
                                    weight: snapshot.data.weight.toString(),
                                    age: snapshot.data.age.toString(),
                                    gender: snapshot.data.gender.toString(),
                                    address: snapshot.data.user.province.toString() +
                                        ', ' +
                                        snapshot.data.user.address.toString()),
                              ],
                            ),


                            Visibility(
                                visible: (widget.isMissing) ? false : true,
                                child: SecondDescriptionCard(
                                    urlImage: snapshot.data.user.image.toString(),
                                    name: snapshot.data.user.name.toString(),
                                    updatedAt: snapshot.data.updatedAt.toString(),
                                    history: snapshot.data.history.toString(),
                                    personality: snapshot.data.personality.toString(),
                                    observations: snapshot.data.observation.toString())
                            )

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

                    return  Column(
                      children: children,
                    );
                  }
              ),
            if(widget.isMissing)
              FutureBuilder<DisappearanceDetail>(
                  future: services.getDisappearance(widget.id),
                  builder: (BuildContext context,
                      AsyncSnapshot<DisappearanceDetail> snapshot) {
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
                                    name: snapshot.data.name.toString(),
                                    description: snapshot.data.description.toString(),
                                    address: snapshot.data.country.toString() +
                                        ', ' +
                                        snapshot.data.province.toString()),
                              ],
                            ),
                            SecondDescriptionCard(
                              name: snapshot.data.userName,
                              updatedAt: snapshot.data.createdAt,
                              lastSeen: snapshot.data.lastSeen,
                            )
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
          ],
        ),
      )
    );
  }
}

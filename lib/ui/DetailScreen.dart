import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/MaleAndFemaleIconComponent.dart';
import 'package:nicamal_app/io/Services.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({Key key, this.id}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Color greyBackground = Color.fromARGB(255, 245, 245, 245);
  Services services = Services();

  @override
  Widget build(BuildContext context) {
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
                                      bottomLeft: Radius.circular(100)))),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 32, horizontal: 16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromRGBO(254, 254, 254, 0.5),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    icon: Icon(Icons.arrow_back),
                                    color: Colors.green),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: height * 0.6,
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24 ),
                              child: Container(
                                width: double.infinity,
                                height: 145,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.16),
                                        spreadRadius: 5,
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      )
                                    ]),
                                child: Padding (
                                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                                  child: Column (
                                    children: [
                                      Padding (
                                        padding: EdgeInsets.only(bottom: 16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data.name,
                                              style: TextStyle(fontFamily: 'Quicksand', fontSize: 20, fontWeight: FontWeight.bold),
                                            ),

                                            iconSelect(context, snapshot.data.gender, 20)
                                          ],
                                        ),
                                      ),

                                      Padding(
                                          padding: EdgeInsets.only(bottom: 6),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data.species,
                                              style: TextStyle(fontFamily: 'Quicksand', fontSize: 14),
                                            ),

                                            Text(
                                              "Peso: " + snapshot.data.weight.toString(),
                                              style: TextStyle(fontFamily: 'Quicksand', fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),

                                      Padding(
                                          padding: EdgeInsets.only(bottom: 6),
                                        child: Row (
                                          children: [
                                            Text('1 año de edad', style: TextStyle(fontFamily: 'Quicksand', fontSize: 14),),
                                          ],
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 8, right: 4),
                                            child: Icon(
                                              Icons.location_on,
                                              size: 13,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              snapshot.data.user.country + ', ' + snapshot.data.user.province,
                                              style: TextStyle(
                                                  fontFamily: 'Quicksand',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                  color: Colors.grey.shade500),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                )
                              ),
                            ),
                          ],

                        )
                      ],
                    )
                  ],
                ),
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                Center(
                  child: Text(snapshot.error.toString()),
                )
              ];
            } else {
              children = <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                )
              ];
            }

            return Container(
              child: Column(
                children: children,
              ),
            );
          }),
    );
  }
}

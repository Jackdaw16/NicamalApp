import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/models/viewModels/shelter_view_model.dart';

import 'custom_painter.dart';

class ProfileComponent extends StatefulWidget {
  final UserShelterDetail shelter;

  const ProfileComponent({Key key, this.shelter}) : super(key: key);

  @override
  _ProfileComponentState createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {

  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;

    if(widget.shelter != null) {
      return shelterProfileView(mediaSize);
    }

    return Center(child: Text("I try xD"));
  }

  Widget shelterProfileView(Size size) {
    return Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.5,
              decoration: BoxDecoration(color: Colors.amber),
            ),
            Container(
              child: CustomPaint(
                size: Size(size.width, size.height * 0.9),
                painter: RPSCustomPainter(),
              ),
            ),


            Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: Container (
                width: double.infinity,
                height: size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.8 / 1,
                      child: Container (
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
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.shelter.name,
                                style: TextStyle (
                                    fontFamily: 'Quicksand',
                                    fontSize: 23,
                                    fontWeight: FontWeight.w200
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 2),
                                      child: Icon(
                                        Icons.location_on,
                                        size: 25,
                                      ),
                                    ),

                                    Text(
                                      widget.shelter.province + ', ' + widget.shelter.address,
                                      style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontSize: 13,
                                          color: Colors.black38
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              if(widget.shelter.urlDonation != null || widget.shelter.urlDonation.toString().isNotEmpty)
                                ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape:
                                      MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                          )),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(greenPrimary),
                                    ),
                                    child: Container(
                                      width: 90,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text('Donar', style: TextStyle(fontFamily: 'Quicksand', fontSize: 12),),
                                      ),
                                    )
                                )

                            ],
                          ),
                        )
                      ),
                    ),

                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 300,
                        ),

                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(widget.shelter.image),
                        ),
                      ],
                    )

                  ],
                ),
              )
            )
          ],
        ));
  }
}

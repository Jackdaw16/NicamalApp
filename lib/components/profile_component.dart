import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/nicamal_icons_icons.dart';
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

    if (widget.shelter != null) {
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
                height: size.height,
                child: Container(
                  width: double.infinity,
                  height: size.height,
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          AspectRatio(
                            aspectRatio: 1.8 / 1,
                            child: Container(
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
                                        style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 23,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 0),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: 2),
                                              child: Icon(
                                                Icons.location_on,
                                                size: 25,
                                              ),
                                            ),
                                            Text(
                                              widget.shelter.province +
                                                  ', ' +
                                                  widget.shelter.address,
                                              style: TextStyle(
                                                  fontFamily: 'Quicksand',
                                                  fontSize: 13,
                                                  color: Colors.black38),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (widget.shelter.urlDonation != null ||
                                          widget.shelter.urlDonation
                                              .toString()
                                              .isNotEmpty)
                                        ElevatedButton(
                                            onPressed: () {},
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(12.0),
                                                  )),
                                              backgroundColor:
                                              MaterialStateProperty.all<Color>(greenPrimary),
                                            ),
                                            child: Container(
                                              width: 90,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Donar',
                                                  style: TextStyle(
                                                      fontFamily: 'Quicksand',
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ))
                                    ],
                                  ),
                                )),
                          ),

                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 7,
                                        blurRadius: 9,
                                      )
                                    ]),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                  NetworkImage(widget.shelter.image),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              Container(
                                height: 140,
                                width: 50,
                              ),
                            ],
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      )),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(NicamalIcons.adop, color: Colors.black87,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                                      child: Text('Adopciones', style: TextStyle(fontSize: 10, fontFamily: 'Quicksand', color: Colors.black87),),
                                    ),
                                    Text(widget.shelter.publicationCount.toString(), style: TextStyle(fontSize: 10, fontFamily: 'Quicksand', color: Colors.black87),)
                                  ],
                                )
                            ),
                          ),

                          Container(
                            width: 90,
                            height: 90,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      )),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.warning_amber_rounded, color: Colors.black87,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                                      child: Text('Urgente', style: TextStyle(fontSize: 10, fontFamily: 'Quicksand', color: Colors.black87),),
                                    ),
                                    Text(widget.shelter.urgentCount.toString(), style: TextStyle(fontSize: 10, fontFamily: 'Quicksand', color: Colors.black87),)
                                  ],
                                )
                            ),
                          ),

                          Container(
                            width: 90,
                            height: 90,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      )),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.call, color: Colors.black87,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                                      child: Text('Contacto', style: TextStyle(fontSize: 10, fontFamily: 'Quicksand', color: Colors.black87),),
                                    ),
                                  ],
                                )
                            ),
                          )
                        ],),
                      ),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.16),
                                spreadRadius: 5,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Padding (
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Text('Nuestra historia',
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w300
                                ),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Text(widget.shelter.history,
                                  style: TextStyle(
                                      fontFamily: 'Quicksand', fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w300
                                  ),),
                              ),

                            ],
                          ),
                        )
                      )
                    ],
                  )
                ))
          ],
        ));
  }
}

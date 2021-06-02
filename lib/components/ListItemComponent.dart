import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';
import 'package:nicamal_app/ui/DetailScreen.dart';

import 'MaleAndFemaleIconComponent.dart';
import 'PopUpMenu.dart';
import 'nicamal_icons_icons.dart';

class ListItemsComponent extends StatefulWidget {
  final int id;
  final String name;
  final String image;
  final String gender;
  final String species;
  final String country;
  final String province;
  final String description;
  final bool isMissing;
  const ListItemsComponent({Key key, this.id, this.name, this.image, this.gender, this.species, this.country, this.province, this.description, this.isMissing}) : super(key: key);

  @override
  _ListItemsComponentState createState() => _ListItemsComponentState();
}

class _ListItemsComponentState extends State<ListItemsComponent> {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                  id: widget.id,
                  isMissing: widget.isMissing,
                )));
      },
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
                width: width,
                height: 110,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.16),
                        spreadRadius: 5,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Row(
                  children: [
                    Container(
                      width: 145,
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                        (widget.name.length <= 4)
                                            ? 40
                                            : 55,
                                        child: Text(
                                          widget.name,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              color: greenAccent,
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      if(widget.gender != null)
                                        Visibility(
                                            visible: (widget.gender == null) ? false : true,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                              child: iconSelect(
                                                  context, widget.gender, 14),
                                            )
                                        ),
                                    ],
                                  ),
                                  popUpMenu(context, Colors.black),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        if(widget.species != null)
                                          Visibility(
                                            visible: (widget.species == null) ? false : true,
                                            child: Expanded(
                                              child: Text(
                                                widget.species,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Quicksand',
                                                    color: Colors.grey.shade600),
                                              ),
                                            ),
                                          ),
                                        if(widget.description != null)
                                          Visibility(
                                            visible: (widget.description == null) ? false : true,
                                            child: Expanded(
                                              child: Text(
                                                widget.description,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Quicksand',
                                                    color: Colors.grey.shade600),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
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
                                  Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          widget.country +
                                              ', ' +
                                              widget.province,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                              color: Colors.grey.shade500),
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            Stack(children: [
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Hero(
                    tag: 'image' + widget.id.toString(),
                    child: Container(
                      width: 130.0,
                      height: 130.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.image),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.16),
                              spreadRadius: 5,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            )
                          ]),
                    ),
                  ))
            ]),
          ],
        ),
      ),
    );
  }
}
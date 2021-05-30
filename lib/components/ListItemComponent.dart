import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';
import 'package:nicamal_app/ui/DetailScreen.dart';

import 'MaleAndFemaleIconComponent.dart';
import 'nicamal_icons_icons.dart';

Widget ListItemsComponent(
    BuildContext context, int index, PublicationsResponseForList publication) {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;

  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(
                    id: publication.id,
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
                                      (publication.name.toString().length <= 4)
                                          ? 40
                                          : 55,
                                  child: Text(
                                    publication.name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        color: greenAccent,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.0),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: iconSelect(
                                      context, publication.gender, 14),
                                )
                              ],
                            ),
                            menu(context),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 4),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      publication.species.toString(),
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Quicksand',
                                          color: Colors.grey.shade600),
                                    ),
                                  ),
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
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                publication.user.country +
                                    ', ' +
                                    publication.user.province,
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
                    ),
                  ))
                ],
              )),
          Stack(children: [
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Hero(
                  tag: 'image' + publication.id.toString(),
                  child: Container(
                    width: 130.0,
                    height: 130.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(publication.image),
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

Widget menu(BuildContext context) {
  return Container(
      width: 20,
      height: 20,
      child: PopupMenuButton(
          iconSize: 16,
          padding: EdgeInsets.only(right: 16),
          onSelected: handleClick,
          itemBuilder: (BuildContext context) {
            return {'Add favorite', 'Report'}.map((String choice) {
              return PopupMenuItem<String>(
                child: (choice == 'Report')
                    ? Text(choice, style: TextStyle(color: Colors.red))
                    : Text(choice),
                value: choice,
              );
            }).toList();
          }));
}

void handleClick(String value) {
  switch (value) {
    case 'Add favorite':
      break;
    case 'Report':
      break;
  }
}

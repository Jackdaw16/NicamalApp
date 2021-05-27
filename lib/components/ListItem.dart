import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';

import 'nicamal_icons_icons.dart';

Widget ListItems(BuildContext context, int index, PublicationsResponseForList publication) {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;

  return GestureDetector(
    onTap: () {
      print('ItemPressed');
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
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 160),
                          child: Row(
                            children: [
                              Text(
                                publication.name,
                                style: TextStyle(
                                    color: greenAccent,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: IconSelect(context, publication.gender),
                              )
                            ],
                          ),
                        ),
                        menu(context),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 160),
                        child: Row(
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
                                publication.user.country + ', ' + publication.user.province,
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: Colors.grey.shade500),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              )),
          Stack(children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                width: 130.0,
                height: 130.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(publication.image), fit: BoxFit.cover),
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
            )
          ]),
        ],
      ),
    ),
  );
}

Widget IconSelect(BuildContext context, String gender) {
  if (gender == 'male') {
    return Icon(
      NicamalIcons.male,
      size: 13,
    );
  } else if (gender == 'female') {
    return Icon(
      NicamalIcons.female,
      size: 14,
    );
  }

  return Icon(
    NicamalIcons.male,
    size: 16,
  );
}

Widget menu(BuildContext context) {
  return PopupMenuButton(
      iconSize: 16,
      onSelected: handleClick,
      itemBuilder: (BuildContext context) {
        return {'Add favorite', 'Report'}.map((String choice) {
          return PopupMenuItem<String>(
            child: Text(choice),
            value: choice,
          );
        }).toList();
      });
}

void handleClick(String value) {
  switch (value) {
    case 'Add favorite':
      break;
    case 'Report':
      break;
  }
}

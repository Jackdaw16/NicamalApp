import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget popUpMenu(BuildContext context, Color color) {
  return Container(
      width: 20,
      height: 20,
      child: PopupMenuButton(
          iconSize: 16,
          icon: Icon(Icons.more_vert, color: color),
          padding: EdgeInsets.zero,
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
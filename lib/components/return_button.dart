import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

bool safeArea(double padding) {
  if (padding > 0) {
    return true;
  }

  return false;
}

Widget backButton(BuildContext context) {
  return SafeArea(
      top: safeArea(MediaQuery.of(context).viewPadding.top),
      bottom: safeArea(0),
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.16),
                  spreadRadius: 5,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ]),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                splashRadius: 25,
                icon: Icon(Icons.arrow_back),
                color: Colors.green),
          ),
        ),
      ));
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget informationWarning(Color greenPrimary, String textError) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.info_outline_rounded, color: greenPrimary, size: 60),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Text(
          textError,
          style: TextStyle(
            fontFamily: 'Quicksand',
          ),
        ),
      )
    ],
  );
}
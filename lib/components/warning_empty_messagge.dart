import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget informationEmpty(Color greenPrimary) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.info_outline_rounded, color: greenPrimary, size: 60),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Text(
          'Sorry, we have not found what you are looking for',
          style: TextStyle(
            fontFamily: 'Quicksand',
          ),
        ),
      )
    ],
  );
}
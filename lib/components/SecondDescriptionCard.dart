import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime date) =>
    new DateFormat("MMMM d, yyyy", 'es').format(date);

Widget SecondDescriptionCard(BuildContext context, String urlImage, String name,
    String updatedAt, String history, String personality, String observation) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
    child: Container(
      width: double.infinity,
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
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.16),
                      spreadRadius: 2,
                      blurRadius: 6,
                    )
                  ]),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(urlImage),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formatDate(DateTime.parse(updatedAt)),
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    history + '. ' + personality + '. ' + observation,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Quicksand'),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    ),
  );
}

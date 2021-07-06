import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SecondDescriptionCard extends StatelessWidget {
  final String urlImage;
  final String name;
  final String updatedAt;
  final String history;
  final String personality;
  final String observations;
  final String lastSeen;
  const SecondDescriptionCard({Key key, this.urlImage, this.name, this.updatedAt, this.history, this.lastSeen, this.personality, this.observations}) : super(key: key);

  String formatDate(DateTime date) =>
      new DateFormat("MMMM d, yyyy", 'es').format(date);

  @override
  Widget build(BuildContext context) {
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
                  if(urlImage != null)
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
                        backgroundImage: NetworkImage(this.urlImage),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  Padding(
                    padding: (urlImage == null) ? EdgeInsets.zero : EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.name,
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          formatDate(DateTime.parse(this.updatedAt)),
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
                  if (history != null && personality != null && observations != null)
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            history + '. ' + personality + '. ' + observations,
                            softWrap: true,
                            style: TextStyle(fontFamily: 'Quicksand'),
                          ),
                        )),
                  if(history != null && personality == null && observations == null)
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            history,
                            softWrap: true,
                            style: TextStyle(fontFamily: 'Quicksand'),
                          ),
                        )),
                  if(history != null && personality != null && observations == null)
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            history + '. ' + personality,
                            softWrap: true,
                            style: TextStyle(fontFamily: 'Quicksand'),
                          ),
                        )),
                  if(history != null && personality == null && observations != null)
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            history + '. ' + observations,
                            softWrap: true,
                            style: TextStyle(fontFamily: 'Quicksand'),
                          ),
                        )),
                  if(lastSeen != null)
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            lastSeen,
                            softWrap: true,
                            style: TextStyle(fontFamily: 'Quicksand'),
                          ),
                        )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nicamal_app/components/MaleAndFemaleIconComponent.dart';

Widget DescriptionCard(BuildContext context, String name, String specie,
    String weight, String age, String gender, String addres) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      AspectRatio(
        aspectRatio: 1 / 1.3,
        child: Container(
          height: 300,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
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
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            name,
                            softWrap: true,
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                          iconSelect(context, gender, 20)
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              specie,
                              softWrap: true,
                              style: TextStyle(
                                  fontFamily: 'Quicksand', fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Text(
                              "Peso: " + weight.toString(),
                              style: TextStyle(
                                  fontFamily: 'Quicksand', fontSize: 14),
                            ),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Text(
                            '"1 año de edad"',
                            style: TextStyle(
                                fontFamily: 'Quicksand', fontSize: 14),
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
                            addres,
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
                ))),
      ),
    ],
  );
}

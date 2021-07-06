import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nicamal_app/components/gender_icon_component.dart';

class DescriptionCard extends StatelessWidget {
  final String name;
  final String specie;
  final String weight;
  final String age;
  final String gender;
  final String address;
  final String description;

  const DescriptionCard({Key key, this.name, this.specie, this.weight, this.age, this.gender, this.address, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                  this.name,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            if(this.gender != null)
                              iconSelect(context, gender, 20)
                          ],
                        ),
                      ),
                      if(this.specie != null)
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
                      if(this.weight != null)
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
                      if(this.age != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Text(
                                this.age,
                                style: TextStyle(
                                    fontFamily: 'Quicksand', fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      if(this.description != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  this.description,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'Quicksand', fontSize: 14),
                                ),
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
                              address,
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
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/pop_up_menu.dart';

class ShelterListItemComponent extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String address;
  final String province;
  final int publicationCount;

  const ShelterListItemComponent({Key key, this.id, this.name, this.image, this.province, this.address, this.publicationCount}) : super(key: key);

  @override
  _ShelterListItemComponentState createState() => _ShelterListItemComponentState();
}

class _ShelterListItemComponentState extends State<ShelterListItemComponent> {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => {},
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
                                        (widget.name.length <= 4)
                                            ? 40
                                            : 55,
                                        child: Text(
                                          widget.name,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              color: greenAccent,
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  popUpMenu(color: Colors.black, letFavorite: false),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        if(widget.publicationCount != null)
                                          Expanded(
                                            child: Text(
                                              widget.publicationCount.toString() + " adopciones",
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
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
                                  if(widget.address != null)
                                    Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text(
                                            widget.province +
                                                ', ' +
                                                widget.address,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          ),
                                        )),
                                  if(widget.address == null)
                                    Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text(
                                            widget.province,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          ),
                                        ))
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
                    tag: 'image' + widget.id.toString(),
                    child: Container(
                      width: 130.0,
                      height: 130.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.image),
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
}

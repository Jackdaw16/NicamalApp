import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nicamal_app/io/FileManager.dart';
import 'package:nicamal_app/io/GetImage.dart';

class PublishDisappearanceScreen extends StatefulWidget {
  const PublishDisappearanceScreen({Key key}) : super(key: key);

  @override
  _PublishDisappearanceScreenState createState() =>
      _PublishDisappearanceScreenState();
}

class _PublishDisappearanceScreenState
    extends State<PublishDisappearanceScreen> {
  String _image;
  GetImage getImage = GetImage();
  FileManager fileManager = FileManager();
  String _provinceSelected;
  final Color greyBackground = Color.fromARGB(255, 245, 245, 245);
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List<String> listOfItems) {
    List<DropdownMenuItem<String>> items = List();
    for(String province in listOfItems) {
      items.add(DropdownMenuItem(value: province,child: Text(province)));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        backgroundColor: greyBackground,
        body: FutureBuilder<List<String>>(
            future: fileManager.getProvincesList(),
            builder: (BuildContext context,
                AsyncSnapshot<List<String>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  Column(
                    children: [
                      Stack(
                        children: [
                          if (_image == null)
                            Container(
                              width: double.infinity,
                              height: height * 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(100))
                              ),
                              child: GestureDetector(
                                onTap: () {},
                              ),
                            ),
                          if (_image != null)
                            Container(
                              width: double.infinity,
                              height: height * 0.5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(File(_image)),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(100))),
                              child: GestureDetector(
                                onTap: () {},
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 48, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                  Color.fromRGBO(254, 254, 254, 0.6),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      icon: Icon(Icons.arrow_back),
                                      color: Colors.green),
                                ),
                                if (_image != null)
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                    Color.fromRGBO(254, 254, 254, 0.6),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _image = null;
                                          });
                                        },
                                        icon: Icon(Icons.close),
                                        color: Colors.green),
                                  ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                height: height * 0.53,
                              ),

                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor:
                                      Color.fromRGBO(254, 254, 254, 1),
                                      child: IconButton(
                                          onPressed: () async {
                                            PickedFile image = await getImage
                                                .getImageFromGallery();
                                            setState(() {
                                              _image = image.path;
                                            });
                                            print(_image);
                                          },
                                          icon: Icon(Icons.photo_library,
                                            color: greenAccent,)),
                                    ),
                                    SizedBox(width: 20,),
                                    CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                        Color.fromRGBO(254, 254, 254, 1),
                                        child: IconButton(
                                            onPressed: () async {
                                              PickedFile image = await getImage
                                                  .getImageFromCamera();
                                              setState(() {
                                                _image = image.path;
                                              });
                                              print(_image);
                                            },
                                            icon: Icon(Icons.camera_alt,
                                              color: greenAccent,))
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
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
                          child: Column(
                            children: [
                              textFieldForForm('Name*', 1),
                              textFieldForForm('Animal description*', null),
                              textFieldForForm('Last Seen*', null),
                              /*Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                              child: ),*/
                              DropdownButtonFormField(
                                value: _provinceSelected,
                                items: buildDropdownMenuItems(snapshot.data),
                                menuMaxHeight: 500,
                                onChanged: (value) {
                                  setState(() {
                                    _provinceSelected = value;
                                  });
                                },
                                style: TextStyle(fontFamily: 'Quicksand', fontSize: 12, color: Colors.black),
                                decoration: InputDecoration (
                                  labelText: 'Province*',
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelStyle: TextStyle(fontFamily: 'Quicksand', color: greenAccent, fontSize: 15),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: greenAccent)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: greenPrimary, width: 2)),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[];
              } else {
                children = <Widget>[
                  CircularProgressIndicator()
                ];
              }
              return SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              );
            }
        )
    );
  }

  Widget textFieldForForm(String hintText, var maxLines) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: TextField(
          onChanged: (text) =>
          {
          },
          style: TextStyle(fontFamily: 'Quicksand', fontSize: 12, color: Colors.black),
          decoration: InputDecoration(
            labelText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(fontFamily: 'Quicksand', color: greenAccent, fontSize: 15),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: greenAccent)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: greenPrimary, width: 2)),

          ),
          maxLines: maxLines,
        )
    );
  }
}

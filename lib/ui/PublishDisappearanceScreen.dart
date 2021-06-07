import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nicamal_app/io/GetImage.dart';
import 'package:nicamal_app/ui/HomeScreen.dart';

class PublishDisappearanceScreen extends StatefulWidget {
  const PublishDisappearanceScreen({Key key}) : super(key: key);

  @override
  _PublishDisappearanceScreenState createState() => _PublishDisappearanceScreenState();
}

class _PublishDisappearanceScreenState extends State<PublishDisappearanceScreen> {
  String _image;
  GetImage getImage = GetImage();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Container(),
                  ),

                  Container (
                    width: double.infinity,
                    child: Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor:
                          Color.fromRGBO(254, 254, 254, 1),
                          child: IconButton(onPressed: () async {
                            PickedFile image = await getImage.getImageFromGallery();
                            setState(() {
                              _image = image.path;
                            });
                            print(_image);
                          }, icon: Icon(Icons.photo_library, color: greenAccent,)),
                        ),
                        SizedBox(width: 20,),
                        CircleAvatar(
                            radius: 25,
                            backgroundColor:
                            Color.fromRGBO(254, 254, 254, 1),
                            child: IconButton(onPressed: () async {
                              PickedFile image = await getImage.getImageFromCamera();
                              setState(() {
                                _image = image.path;
                              });
                              print(_image);
                            }, icon: Icon(Icons.camera_alt, color: greenAccent,))
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

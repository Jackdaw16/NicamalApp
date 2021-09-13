import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nicamal_app/components/return_button.dart';
import 'package:nicamal_app/io/get_image.dart';

class ShelterRegisterScreen extends StatefulWidget {
  const ShelterRegisterScreen({Key key}) : super(key: key);

  @override
  _ShelterRegisterScreenState createState() => _ShelterRegisterScreenState();
}

class _ShelterRegisterScreenState extends State<ShelterRegisterScreen> {
  var _imageSelected;

  GetImage _getImage = GetImage();

  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        child: ClipOval(
                          child: (_imageSelected != null)
                              ? Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(File(_imageSelected)),
                                        fit: BoxFit.cover),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {},
                                  ),
                                )
                              : Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                    backgroundColor: Color.fromRGBO(254, 254, 254, 1),
                    child: IconButton(
                        onPressed: () async {
                          PickedFile image = await _getImage
                              .getImageFromGallery()
                              .then((value) {
                            setState(() {
                              _imageSelected = value.path;
                            });
                          }).timeout(Duration(seconds: 5));

                          print(_imageSelected.toString());
                        },
                        splashRadius: 29,
                        icon: Icon(
                          Icons.photo_library,
                          color: greenAccent,
                        )),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
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
                        backgroundColor: Color.fromRGBO(254, 254, 254, 1),
                        child: IconButton(
                            onPressed: () async {
                              PickedFile image =
                                  await _getImage.getImageFromCamera();
                              setState(() {
                                _imageSelected = image.path;
                              });
                            },
                            splashRadius: 29,
                            icon: Icon(
                              Icons.camera_alt,
                              color: greenAccent,
                            )))),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

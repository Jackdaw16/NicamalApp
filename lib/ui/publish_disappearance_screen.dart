import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nicamal_app/io/get_image.dart';
import 'package:nicamal_app/io/services.dart';
import 'package:nicamal_app/models/viewModels/disappearance_view_model.dart';
import 'package:nicamal_app/components/warnings_notifications_component.dart';
import 'package:nicamal_app/io/form_validation.dart';

class PublishDisappearanceScreen extends StatefulWidget {
  const PublishDisappearanceScreen({Key key}) : super(key: key);

  @override
  _PublishDisappearanceScreenState createState() =>
      _PublishDisappearanceScreenState();
}

class _PublishDisappearanceScreenState
    extends State<PublishDisappearanceScreen> {
  String _image;
  int btnState = 0;

  GetImage getImage = GetImage();
  Services services = Services();

  void showErrorOverlay(String error) {
    Navigator.of(context)
        .overlay
        .insert(OverlayEntry(builder: (BuildContext context) {
      return DangerWarning(dangerText: error, duration: 2);
    }));
  }

  void showInfoOverlay(String info) {
    Navigator.of(context)
        .overlay
        .insert(OverlayEntry(builder: (BuildContext context) {
      return InfoWarning(infoText: info, duration: 2);
    }));
  }

  void showSuccessOverlay(String message) {
    Navigator.of(context)
        .overlay
        .insert(OverlayEntry(builder: (BuildContext context) {
      return SuccessWarning(successText: message, duration: 2);
    }));
  }

  DisappearanceDetail disappearance = DisappearanceDetail();

  final _formKey = GlobalKey<FormState>();
  final Color greyBackground = Color.fromARGB(255, 245, 245, 245);
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: greyBackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  if (_image == null)
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: height * 0.5,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(100))),
                          child: GestureDetector(
                            onTap: () async {
                              PickedFile image =
                                  await getImage.getImageFromCamera();
                              setState(() {
                                _image = image.path;
                                disappearance.image = _image;
                              });
                            },
                          ),
                        ),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.center,
                          child:
                              Icon(Icons.image, color: Colors.white, size: 120),
                        ))
                      ],
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
                    padding: EdgeInsets.symmetric(vertical: 48, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromRGBO(254, 254, 254, 0.6),
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
                            backgroundColor: Color.fromRGBO(254, 254, 254, 0.6),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _image = null;
                                    disappearance.image = _image;
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
                                radius: 25,
                                backgroundColor:
                                    Color.fromRGBO(254, 254, 254, 1),
                                child: IconButton(
                                    onPressed: () async {
                                      PickedFile image =
                                          await getImage.getImageFromGallery();
                                      setState(() {
                                        _image = image.path;
                                        disappearance.image = _image;
                                      });
                                      print(_image);
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
                                    radius: 25,
                                    backgroundColor:
                                        Color.fromRGBO(254, 254, 254, 1),
                                    child: IconButton(
                                        onPressed: () async {
                                          PickedFile image = await getImage
                                              .getImageFromCamera();
                                          setState(() {
                                            _image = image.path;
                                            disappearance.image = _image;
                                          });
                                          print(_image);
                                        },
                                        splashRadius: 29,
                                        icon: Icon(
                                          Icons.camera_alt,
                                          color: greenAccent,
                                        )))),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 24),
                              child: TextFormField(
                                onChanged: (text) {
                                  setState(() {
                                    disappearance.name = text;
                                  });
                                },
                                validator: (text) {
                                  if (text.isEmpty) {
                                    return 'Este campo es obligatorio';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: formFieldStyle(
                                    'Nombre*', 'Nombre del animal'),
                                maxLines: 1,
                                autocorrect: false,
                              )),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 24),
                              child: TextFormField(
                                onChanged: (text) {
                                  setState(() {
                                    disappearance.description = text;
                                  });
                                },
                                validator: (text) {
                                  if (text.isEmpty) {
                                    return 'Este campo es obligatorio';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: formFieldStyle(
                                    'Descripción del animal*',
                                    'Un gato pequeño con pelaje blanco...'),
                                maxLines: null,
                                autocorrect: false,
                              )),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 24),
                              child: TextFormField(
                                onChanged: (text) {
                                  disappearance.lastSeen = text;
                                },
                                validator: (text) {
                                  if (text.isEmpty) {
                                    return 'Este campo es obligatorio';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: formFieldStyle(
                                    'Visto por ultima vez*',
                                    'Fue visto por ultima vez en la plaza...'),
                                maxLines: null,
                                autocorrect: false,
                              )),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 24),
                              child: TextFormField(
                                onChanged: (text) {
                                  disappearance.province = text;
                                },
                                validator: (text) {
                                  if (text.isEmpty) {
                                    return 'Este campo es obligatorio';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: formFieldStyle('Provincia*', ''),
                                maxLines: 1,
                                autocorrect: false,
                              )),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 24),
                              child: TextFormField(
                                onChanged: (text) {
                                  setState(() {
                                    disappearance.userName = text;
                                  });
                                },
                                validator: (text) {
                                  if (text.isEmpty) {
                                    return 'Este campo es obligatorio';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration:
                                    formFieldStyle('Nombre del dueño*', ''),
                                maxLines: 1,
                                autocorrect: false,
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 8, right: 24, left: 24, bottom: 24),
                              child: TextFormField(
                                onChanged: (text) {
                                  setState(() {
                                    disappearance.telephoneContact = text;
                                  });
                                },
                                validator: (text) {
                                  if (!text.isValidPhone(text)) {
                                    return 'El número de telefono no es valido';
                                  } else if (text.isEmpty) {
                                    return 'Este campo es obligatorio';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration:
                                    formFieldStyle('Telefono de contacto*', ''),
                                maxLines: 1,
                                autocorrect: false,
                              )),
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                child: Container(width: double.infinity, child: inputButton()),
              )
            ],
          ),
        ));
  }

  Widget inputButton() {
    return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState.validate() && _image != null) {
            setState(() {
              btnState = 1;
            });
            await services.postDisappearance(disappearance).then((value) {
              if (value != null) {
                setState(() {
                  btnState = 0;
                  showSuccessOverlay(
                      'Se ha publicado la desaparición, Esperamos que lo encuentre pronto');

                  Navigator.pop(context, true);
                });
              }
            }).onError((error, stackTrace) {
              setState(() {
                btnState = 0;
              });
              showErrorOverlay(
                  'Error inesperado\n\nCompruebe su conexión a internet y vuelva a intentarlo');
            });
          } else {
            showInfoOverlay(
                'Se requiere una imagen para tener más información acerca de la desaparición');
          }
        },
        child: buttonStyle(),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            )),
            backgroundColor: MaterialStateProperty.all<Color>(greenPrimary)));
  }

  InputDecoration formFieldStyle(String labelText, String hintText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: TextStyle(fontFamily: 'Quicksand', color: greenAccent),
      hintStyle: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.blueGrey.shade300,
          fontSize: 12),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: greenAccent)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: greenPrimary, width: 2)),
    );
  }

  Widget buttonStyle() {
    if (btnState == 0) {
      return Text(
        'Publicar',
        style: TextStyle(fontFamily: 'Quicksand'),
      );
    } else if (btnState == 1) {
      return Container(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }
}

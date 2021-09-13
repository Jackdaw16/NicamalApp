import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/custom_progress_indicator_component.dart';
import 'package:nicamal_app/components/register_form.dart';
import 'package:nicamal_app/components/return_button.dart';
import 'package:nicamal_app/components/warning_messagge.dart';
import 'package:nicamal_app/components/warnings_notifications_component.dart';
import 'package:nicamal_app/io/services.dart';
import 'package:nicamal_app/models/Images.dart';
import 'package:nicamal_app/models/viewModels/user_view_model.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({Key key}) : super(key: key);

  @override
  _UserRegisterScreenState createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);
  final Color greyBackground = Color.fromARGB(255, 245, 245, 245);

  final _registerFormKey = GlobalKey<FormState>();
  final Services services = Services();

  UserRegister user = UserRegister();

  var imageSelected;
  bool isObscure = true;
  bool acceptTermAndConditions = false;

  void changeAcceptTermAndConditions(newVal) {
    setState(() {
      acceptTermAndConditions = newVal;
    });
  }

  void showErrorOverlay(String message) {
    if (message.contains('400')) {
      Navigator.of(context)
          .overlay
          .insert(OverlayEntry(builder: (BuildContext context) {
        return DangerWarning(dangerText: 'Este usuario ya existe', duration: 2);
      }));
    } else if (message.contains('500')) {
      Navigator.of(context)
          .overlay
          .insert(OverlayEntry(builder: (BuildContext context) {
        return DangerWarning(
            dangerText:
                'Error inesperado\n\nCompruebe su conexión a internet y vuelva a intentarlo',
            duration: 2);
      }));
    }
  }

  void showInfoOverlay(String message) {
    Navigator.of(context)
        .overlay
        .insert(OverlayEntry(builder: (BuildContext context) {
      return InfoWarning(infoText: message, duration: 2);
    }));
  }

  Future showSuccessOverlay(String message) async {
    await Navigator.of(context)
        .overlay
        .insert(OverlayEntry(builder: (BuildContext context) {
      return SuccessWarning(successText: message, duration: 3);
    }));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: greyBackground,
        body: FutureBuilder(
          future: services.getImages(),
          builder: (context, snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 16),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        backButton(context),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 8),
                      child: SizedBox(
                          width: size.width * 0.6,
                          height: size.width * 0.3,
                          child: imageGrid(snapshot.data)),
                    ),
                    Container(
                      width: size.width * 0.3,
                      height: size.width * 0.3,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          child: ClipOval(
                            child: (imageSelected != null)
                                ? Image.network(
                                    imageSelected,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: RegisterForm(
                    formKey: _registerFormKey,
                    user: user,
                    getTermAndConditions: acceptTermAndConditions,
                    setTermAndConditions: changeAcceptTermAndConditions,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: Container(
                      width: double.infinity,
                      child: registerButton(),
                    ))
              ];
            } else if (snapshot.hasError ||
                snapshot.connectionState == ConnectionState.none) {
              children = <Widget>[
                Container(
                  width: double.infinity,
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      informationWarning(
                          greenPrimary, snapshot.error.toString()),
                      TextButton(
                        onPressed: () {},
                        child: Text('Reset',
                            style: TextStyle(
                                fontFamily: 'Quicksand', color: greenPrimary)),
                      ),
                    ],
                  ),
                )
              ];
            } else {
              children = <Widget>[
                Container(
                  width: double.infinity,
                  height: size.height,
                  child: Center(
                    child: CustomProgressIndicatorComponent(),
                  ),
                )
              ];
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          },
        ));
  }

  Widget imageGrid(List<Images> images) {
    return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemCount: images.length,
        itemBuilder: (context, index) => Container(
                child: GestureDetector(
              onTap: () {
                setState(() {
                  imageSelected = images[index].image;
                  user.image = imageSelected;
                });
              },
              child: Image.network(images[index].image),
            )));
  }

  Widget registerButton() {
    return ElevatedButton(
        onPressed: () async {
          if (_registerFormKey.currentState.validate() &&
              acceptTermAndConditions &&
              imageSelected != null) {
            await services.userRegister(user).then((value) {
              showSuccessOverlay(
                      'Se ha registrado con exito\nCompruebe su correo para verificar su cuenta')
                  .then((value) => Navigator.pop(context, true));
            }).onError((error, stackTrace) {
              showErrorOverlay(error.toString());
            });
          } else if (imageSelected == null) {
            showInfoOverlay('Es necesario elegir una imagen para tu perfil');
          } else if (!acceptTermAndConditions) {
            showInfoOverlay(
                'Es necesario haber leido y aceptar las condiciones de uso de la aplicación');
          }
        },
        child: Text(
          'Registrarse',
          style: TextStyle(
            fontFamily: 'Quicksand',
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          )),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all<Color>(greenPrimary),
        ));
  }
}

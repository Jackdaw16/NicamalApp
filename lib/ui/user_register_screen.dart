import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/custom_progress_indicator_component.dart';
import 'package:nicamal_app/components/return_button.dart';
import 'package:nicamal_app/components/warning_messagge.dart';
import 'package:nicamal_app/components/warnings_notifications_component.dart';
import 'package:nicamal_app/io/form_validation.dart';
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
                  child: registerForm(size),
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

  Widget registerForm(var size) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.16),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 5))
          ]),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _registerFormKey,
          child: Column(
            children: [
              normalInputField('Nombre*'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: normalInputField('Apellidos'),
              ),
              emailField(),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: passwordField()),
              repeatPasswordField(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: telephoneField(),
              ),
              normalInputField('Provincia*'),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: normalInputField('Dirección*')),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                        child: Checkbox(
                          value: acceptTermAndConditions,
                          onChanged: (bool value) {
                            setState(() {
                              acceptTermAndConditions = value;
                            });
                          },
                          shape: CircleBorder(),
                          fillColor: MaterialStateProperty.all(greenPrimary),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'He leído y aceptado las condiciones y términos de uso',
                                style: TextStyle(
                                    fontFamily: 'Quicksand', fontSize: 13),
                              )))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
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

  Widget normalInputField(String inputHintText) {
    return TextFormField(
      onChanged: (value) {
        switch (inputHintText) {
          case 'Nombre*':
            user.name = value;
            break;
          case 'Apellidos':
            user.surName = value;
            break;
          case 'Provincia*':
            user.province = value;
            break;
          case 'Dirección*':
            user.address = value;
            break;
        }
      },
      validator: (value) {
        if (inputHintText == 'Apellidos') {
          return null;
        } else if (value.isEmpty) {
          return 'Este campo es obligatorio';
        } else {
          return null;
        }
      },
      decoration: formFieldStyle(inputHintText),
      maxLines: 1,
      autocorrect: false,
    );
  }

  Widget emailField() {
    return TextFormField(
      onChanged: (email) => user.email = email,
      validator: (email) {
        if (email.isEmpty) {
          return 'Este campo es obligatorio';
        } else if (!email.isValidEmail(email)) {
          return 'El email no es valido';
        } else {
          return null;
        }
      },
      decoration: formFieldStyle('Email*'),
      maxLines: 1,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget telephoneField() {
    return TextFormField(
      onChanged: (telephone) => user.telephoneContact = telephone,
      validator: (telephone) {
        if (telephone.isEmpty) {
          return 'Este campo es obligatorio';
        } else if (!telephone.isValidPhone(telephone)) {
          return 'El telefono ingresado no es valido';
        } else {
          return null;
        }
      },
      decoration: formFieldStyle('Teléfono'),
      maxLines: 1,
      autocorrect: false,
      keyboardType: TextInputType.phone,
    );
  }

  Widget passwordField() {
    return TextFormField(
      onChanged: (password) => user.password = password,
      validator: (password) {
        if (password.isEmpty) {
          return 'Este campo es obligatorio';
        } else {
          return null;
        }
      },
      decoration: passwordFormFieldStyle('Contraseña*'),
      obscureText: isObscure,
    );
  }

  Widget repeatPasswordField() {
    return TextFormField(
      onChanged: (password) => user.password = password,
      validator: (passwordForCompare) {
        if (passwordForCompare.isEmpty) {
          return 'Este campo es obligatorio';
        } else if (!passwordForCompare.isTheSamePassword(
            user.password.toString(), passwordForCompare)) {
          return 'Las contraseñas no coinciden';
        } else {
          return null;
        }
      },
      decoration: passwordFormFieldStyle('Repite contraseña*'),
      obscureText: isObscure,
    );
  }

  InputDecoration formFieldStyle(String labelText) {
    return InputDecoration(
      labelText: labelText,
      contentPadding: EdgeInsets.all(0),
      alignLabelWithHint: true,
      labelStyle: TextStyle(
        fontFamily: 'Quicksand',
        color: greenAccent,
        fontSize: 13,
      ),
      hintStyle: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.blueGrey.shade300,
          fontSize: 12),
      suffixIcon: Icon(null),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: greenAccent)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: greenPrimary, width: 2)),
    );
  }

  InputDecoration passwordFormFieldStyle(String labelText) {
    return InputDecoration(
        labelText: labelText,
        contentPadding: EdgeInsets.all(0),
        alignLabelWithHint: true,
        labelStyle: TextStyle(
            fontFamily: 'Quicksand', color: greenAccent, fontSize: 13),
        hintStyle: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.blueGrey.shade300,
            fontSize: 12),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: greenAccent)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: greenPrimary, width: 2)),
        suffixIcon: (isObscure)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = false;
                  });
                },
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: greenPrimary,
                ))
            : IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = true;
                  });
                },
                icon: Icon(
                  Icons.remove_red_eye,
                  color: greenPrimary,
                )));
  }
}

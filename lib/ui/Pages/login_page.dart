import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/nicamal_icon2_icons.dart';
import 'package:nicamal_app/components/warnings_notifications_component.dart';
import 'package:nicamal_app/io/services.dart';
import 'package:nicamal_app/models/viewModels/user_view_model.dart';
import 'package:nicamal_app/io/form_validation.dart';
import 'package:nicamal_app/ui/shelter_register_screen.dart';
import 'package:nicamal_app/ui/user_register_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool imShelter = false;
  Services _services = Services();
  UserLogIn user = UserLogIn();

  final _loginFormKey = GlobalKey<FormState>();
  bool isObscure = true;

  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);
  final Color greyBackground = Color.fromARGB(255, 245, 245, 245);

  void changeShelterLogin() {
    if (!imShelter) {
      setState(() {
        imShelter = true;
      });
    } else {
      setState(() {
        imShelter = false;
      });
    }
  }

  void showOverlay(String error) {
    Navigator.of(context)
        .overlay
        .insert(OverlayEntry(builder: (BuildContext context) {
      if (error.contains('404')) {
        return InfoWarning(
            infoText: 'Email o contraseña incorrecta', duration: 2);
      } else if (error.contains('403')) {
        return DangerWarning(
            dangerText: 'Tu cuenta ha sido suspendida', duration: 2);
      } else {
        return null;
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: greyBackground,
        body: Container(
          width: double.infinity,
          height: size.height,
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.only(top: 55, bottom: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                header(),
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        loginForm(),
                        SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          child: enterButton(),
                        ),
                        Container(
                          width: double.infinity,
                          child: registerButton(),
                        ),
                        AnimatedOpacity(
                          opacity: (!imShelter) ? 1 : 0,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Divider(
                              height: 0.5,
                              thickness: 1,
                              indent: 8,
                              endIndent: 8,
                              color: greenPrimary,
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                            opacity: (!imShelter) ? 1 : 0,
                            curve: Curves.easeInOut,
                            duration: Duration(milliseconds: 500),
                            child: googleLogin())
                      ],
                    ))
              ],
            ),
          )),
        ));
  }

  Widget header() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/nicamal-logo.png'))),
    );
  }

  Widget loginForm() {
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
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              emailField(),
              SizedBox(height: 20),
              passwordField(),
              SizedBox(height: 20),
              ConstrainedBox(
                constraints: BoxConstraints.expand(height: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [forgotPasswordButton()],
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints.expand(height: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [imShelterButton()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget enterButton() {
    return ElevatedButton(
      onPressed: () async {
        if (!imShelter && _loginFormKey.currentState.validate()) {
          var userLogged = await _services
              .userLogIn(user)
              .catchError((onError) => showOverlay(onError.toString()));
        } else if (imShelter && _loginFormKey.currentState.validate()) {
          var userLogged = await _services
              .userShelterLogIn(user)
              .catchError((onError) => showOverlay(onError.toString()));
        }
      },
      child: Text(
        'Acceder',
        style: TextStyle(fontFamily: 'Quicksand', color: greenPrimary),
      ),
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.black12),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          )),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
    );
  }

  Widget registerButton() {
    return ElevatedButton(
        onPressed: () {
          if (!imShelter) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserRegisterScreen()));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShelterRegisterScreen()));
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

  Widget googleLogin() {
    return ElevatedButton(
        onPressed: (!imShelter)
            ? () {
                print('Im already here');
              }
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(NicamalIcon2.google),
            Text(
              'oogle',
              style: TextStyle(fontFamily: 'Quicksand'),
            )
          ],
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          )),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ));
  }

  Widget emailField() {
    return TextFormField(
      onChanged: (email) {
        setState(() {
          user.email = email;
        });
      },
      validator: (email) {
        if (email.isEmpty) {
          return 'Es necesario introducir un email';
        } else if (!email.isValidEmail(email)) {
          return 'No es un email valido';
        } else {
          return null;
        }
      },
      decoration: formFieldStyle('Email'),
      maxLines: 1,
      autocorrect: false,
    );
  }

  Widget passwordField() {
    return TextFormField(
      onChanged: (password) {
        setState(() {
          user.password = password;
        });
      },
      validator: (password) {
        if (password.isEmpty) {
          return 'Es necesario introducir la contraseña';
        } else {
          return null;
        }
      },
      decoration: passwordFormFieldStyle('Contraseña'),
      obscureText: isObscure,
    );
  }

  Widget forgotPasswordButton() {
    return TextButton(
      onPressed: () {},
      child: Text(
        'He olvidado la contraseña',
        style: TextStyle(
          color: greenPrimary,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w300,
          fontSize: 11,
        ),
      ),
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.black12),
          padding: MaterialStateProperty.all(EdgeInsets.all(0))),
    );
  }

  Widget imShelterButton() {
    return TextButton(
      onPressed: changeShelterLogin,
      child: Text(
        (!imShelter) ? 'Soy una protectora' : 'Soy un particular',
        style: TextStyle(
          color: greenPrimary,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w300,
          fontSize: 11,
        ),
      ),
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.black12),
          padding: MaterialStateProperty.all(EdgeInsets.all(0))),
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
        fontSize: 15,
      ),
      hintStyle: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.blueGrey.shade300,
          fontSize: 12),
      icon: Icon(Icons.alternate_email, color: greenAccent, size: 18),
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
        icon: Icon(Icons.lock, color: greenAccent, size: 18),
        labelStyle: TextStyle(
            fontFamily: 'Quicksand', color: greenAccent, fontSize: 15),
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

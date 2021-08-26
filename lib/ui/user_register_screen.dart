import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/custom_progress_indicator_component.dart';
import 'package:nicamal_app/components/warning_messagge.dart';
import 'package:nicamal_app/io/services.dart';
import 'package:nicamal_app/models/Images.dart';

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

  var imageSelected;
  bool isObscure = true;
  bool acceptTermAndConditions = false;

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
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 8),
                      child: SizedBox(
                          width: size.width * 0.6,
                          height: 180,
                          child: imageGrid(snapshot.data)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: (imageSelected == null)
                            ? Colors.grey
                            : Colors.white,
                        backgroundImage: (imageSelected == null)
                            ? null
                            : NetworkImage(imageSelected),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: registerForm(size),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
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
                child: normalInputField('Apellidos*'),
              ),
              emailField(),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.4,
                        child: passwordField(),
                      ),
                      SizedBox(
                        width: size.width * 0.4,
                        child: passwordField(),
                      ),
                    ],
                  )),
              telephoneField(),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: normalInputField('Provincia')),
              normalInputField('Dirección'),
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
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 60,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.1),
        itemCount: images.length,
        itemBuilder: (context, index) => Container(
            height: 20,
            width: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  imageSelected = images[index].image;
                });
              },
              child: Image.network(images[index].image),
            )));
  }

  Widget registerButton() {
    return ElevatedButton(
        onPressed: () {},
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
      onChanged: null,
      validator: null,
      decoration: formFieldStyle(inputHintText),
      maxLines: 1,
      autocorrect: false,
    );
  }

  Widget emailField() {
    return TextFormField(
      onChanged: null,
      validator: null,
      decoration: formFieldStyle('Email*'),
      maxLines: 1,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget telephoneField() {
    return TextFormField(
      onChanged: null,
      validator: null,
      decoration: formFieldStyle('Teléfono'),
      maxLines: 1,
      autocorrect: false,
      keyboardType: TextInputType.phone,
    );
  }

  Widget passwordField() {
    return TextFormField(
      onChanged: null,
      validator: null,
      decoration: passwordFormFieldStyle('Contraseña'),
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

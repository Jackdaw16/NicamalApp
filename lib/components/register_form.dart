import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/io/form_validation.dart';

class RegisterForm extends StatefulWidget {
  GlobalKey<FormState> formKey;
  var user;
  var getTermAndConditions;
  var setTermAndConditions;

  RegisterForm(
      {Key key,
      this.formKey,
      this.user,
      this.getTermAndConditions,
      this.setTermAndConditions})
      : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isObscure = true;

  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);

  @override
  Widget build(BuildContext context) {
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
          key: widget.formKey,
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
                          value: widget.getTermAndConditions,
                          onChanged: (value) => {
                            setState(() {
                              widget.setTermAndConditions(value);
                            })
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

  Widget normalInputField(String inputHintText) {
    return TextFormField(
      onChanged: (value) {
        switch (inputHintText) {
          case 'Nombre*':
            widget.user.name = value;
            break;
          case 'Apellidos':
            widget.user.surName = value;
            break;
          case 'Provincia*':
            widget.user.province = value;
            break;
          case 'Dirección*':
            widget.user.address = value;
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
      onChanged: (email) => widget.user.email = email,
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
      onChanged: (telephone) => widget.user.telephoneContact = telephone,
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
      onChanged: (password) => widget.user.password = password,
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
      onChanged: (password) => widget.user.password = password,
      validator: (passwordForCompare) {
        if (passwordForCompare.isEmpty) {
          return 'Este campo es obligatorio';
        } else if (!passwordForCompare.isTheSamePassword(
            widget.user.password.toString(), passwordForCompare)) {
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

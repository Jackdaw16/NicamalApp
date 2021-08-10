import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/models/viewModels/user_view_model.dart';

class LoginFormComponent extends StatefulWidget {
  final changeShelterLogin;
  final getImShelter;
  final UserLogIn user;

  const LoginFormComponent({Key key, this.changeShelterLogin, this.getImShelter, this.user}) : super(key: key);

  @override
  _LoginFormComponentState createState() => _LoginFormComponentState();
}

class _LoginFormComponentState extends State<LoginFormComponent> {
  final _loginFormKey = GlobalKey<FormState>();
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
            offset: Offset(0, 5)
          )
        ]
      ),
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
                  children: [
                    forgotPasswordButton()
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints.expand(height: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    imShelterButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      onChanged: (email) {
        setState(() {
          widget.user.email = email;
        });
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
          widget.user.password = password;
        });
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
        padding: MaterialStateProperty.all(EdgeInsets.all(0))
      ),
    );
  }

  Widget imShelterButton() {
    return TextButton(
        onPressed: widget.changeShelterLogin,
        child: Text(
          (!widget.getImShelter) ? 'Soy una protectora' : 'Soy un particular',
          style: TextStyle(
            color: greenPrimary,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w300,
            fontSize: 11,
          ),
        ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.black12),
          padding: MaterialStateProperty.all(EdgeInsets.all(0))
      ),
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
          fontFamily: 'Quicksand',
          color: greenAccent,
        fontSize: 15
      ),
      hintStyle: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.blueGrey.shade300,
          fontSize: 12),
      enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: greenAccent)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: greenPrimary, width: 2)),
      suffixIcon: (isObscure) ? IconButton(onPressed: () {
        setState(() {
          isObscure = false;
        });
      }, icon: Icon(Icons.remove_red_eye_outlined, color: greenPrimary,)) : IconButton(
          onPressed: () {
            setState(() {
              isObscure = true;
            });
          }, icon: Icon(Icons.remove_red_eye, color: greenPrimary,))
    );
  }
}

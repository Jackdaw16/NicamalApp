import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/alert_dialogs.dart';
import 'package:nicamal_app/components/login_form_component.dart';
import 'package:nicamal_app/components/nicamal_icon2_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
    final Color greenAccent = Color.fromARGB(255, 24, 157, 139);

    return Scaffold(
      body: SingleChildScrollView (
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              header(),

              SizedBox(height: 20),

              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    LoginFormComponent(),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      child: enterButton(),
                    ),
                    Container(
                      width: double.infinity,
                      child: registerButton(),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        height: 0.5,
                        thickness: 1,
                        indent: 8,
                        endIndent: 8,
                        color: greenPrimary,
                      ),
                    ),

                    googleLogin()
                  ],
                )
              )
            ],
          ),
        )
      ),
    );
  }

  Widget header() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/nicamal-logo.png')
          )
      ),
    );
  }

  Widget enterButton() {
    return ElevatedButton(
        onPressed: () {},
        child: Text('Acceder', style: TextStyle(
         fontFamily: 'Quicksand',
          color: greenPrimary
        ),),
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.black12),
          shape:
          MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              )),
          elevation: MaterialStateProperty.all(0),
          backgroundColor:
          MaterialStateProperty.all<Color>(Colors.white)),
    );
  }

  Widget registerButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Registrarse', style: TextStyle(
          fontFamily: 'Quicksand',
      ),),
      style: ButtonStyle(
          shape:
          MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              )),
          elevation: MaterialStateProperty.all(0),
          backgroundColor:
          MaterialStateProperty.all<Color>(greenPrimary),
    ));
  }

  Widget googleLogin() {
    return ElevatedButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(NicamalIcon2.google),
          Text('oogle', style: TextStyle(fontFamily: 'Quicksand'),)
        ],
      ),
      style: ButtonStyle(
        shape:
        MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            )),
        elevation: MaterialStateProperty.all(0),
        backgroundColor:
        MaterialStateProperty.all<Color>(Colors.red),
      )
    );
  }
}

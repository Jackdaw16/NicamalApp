import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/nicamal_icons_icons.dart';
import 'package:nicamal_app/ui/Pages/AdopList.dart';
import 'package:nicamal_app/ui/Pages/DisappearanceList.dart';
import 'package:nicamal_app/ui/Pages/PublishDisappearance.dart';
import 'package:nicamal_app/ui/Pages/SelectLogin.dart';
import 'package:nicamal_app/ui/Pages/ShelterList.dart';

final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
final Color greenAccent = Color.fromARGB(255, 24, 157, 139);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTab = 0;
  final List<Widget> screens = [
    AdopList(),
    DisappearanceList(),
    PublishDisappearance(),
    ShelterList(),
    SelectLogin()
  ];

  final PageStorageBucket _bucket = PageStorageBucket();
  Widget _currentScreen = AdopList();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: PageStorage(
        child: _currentScreen,
        bucket: _bucket,
      ),
      bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: CircularNotchedRectangle(),
          notchMargin: 10.0,
          child: Container(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: width * 0.20,
                      onPressed: () {
                        setState(() {
                          _currentScreen = AdopList();
                          _currentTab = 0;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(NicamalIcons.adop,
                                color: _currentTab == 0
                                    ? greenAccent
                                    : greenPrimary),
                            Text(
                              'Adop',
                              style: TextStyle(
                                  color: _currentTab == 0
                                      ? greenAccent
                                      : greenPrimary),
                            )
                          ]),
                    ),
                    MaterialButton(
                      minWidth: width * 0.20,
                      onPressed: () {
                        setState(() {
                          _currentScreen = DisappearanceList();
                          _currentTab = 1;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(NicamalIcons.missing,
                                color: _currentTab == 1
                                    ? greenAccent
                                    : greenPrimary),
                            Text(
                              'Missing',
                              style: TextStyle(
                                  color: _currentTab == 1
                                      ? greenAccent
                                      : greenPrimary),
                            )
                          ]),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: width * 0.20,
                      onPressed: () {
                        setState(() {
                          _currentScreen = ShelterList();
                          _currentTab = 3;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.store_mall_directory,
                                color: _currentTab == 3
                                    ? greenAccent
                                    : greenPrimary),
                            Text(
                              'Shelter',
                              style: TextStyle(
                                  color: _currentTab == 3
                                      ? greenAccent
                                      : greenPrimary),
                            )
                          ]),
                    ),
                    MaterialButton(
                      minWidth: width * 0.20,
                      onPressed: () {
                        setState(() {
                          _currentScreen = SelectLogin();
                          _currentTab = 4;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_circle,
                                color: _currentTab == 4
                                    ? greenAccent
                                    : greenPrimary),
                            Text(
                              'Account',
                              style: TextStyle(
                                  color: _currentTab == 4
                                      ? greenAccent
                                      : greenPrimary),
                            )
                          ]),
                    ),
                  ],
                )
              ],
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
      
        onPressed: () {
          setState(() {
            _currentScreen = PublishDisappearance();
            _currentTab = 2;
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 105, 198, 133),
      ),
    );
  }
}

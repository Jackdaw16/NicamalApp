import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/nicamal_icons_icons.dart';
import 'package:nicamal_app/ui/Pages/adopt_list_page.dart';
import 'package:nicamal_app/ui/Pages/disappearance_list_page.dart';
import 'package:nicamal_app/ui/Pages/select_login_page.dart';
import 'package:nicamal_app/ui/Pages/shelter_list_page.dart';
import 'package:nicamal_app/ui/publish_disappearance_screen.dart';

final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
final Color greenAccent = Color.fromARGB(255, 24, 157, 139);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTab = 0;
  PageController _myPage = PageController(initialPage: 0);

  final List<Widget> screens = [
    AdoptList(),
    DisappearanceList(),
    ShelterList(),
    SelectLogin()
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool keyboardIsUp = MediaQuery.of(context).viewInsets.bottom != 0.0;

    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you really want to exit the app?'),
          actions: [
            MaterialButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('No'),
            ),
            MaterialButton(
                onPressed: () => {
                  SystemNavigator.pop()
                },
              child: Text('yes'),
            )
          ],
        )
      );
    }

    return WillPopScope(
        child: Scaffold(
          body: PageView(
            controller: _myPage,
            children: screens,
            onPageChanged: (index) {
              print('Page changes to index  $index');
            },
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
                        Container(
                          width: width * 0.20,
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  _currentTab = 0;
                                  _myPage.animateToPage(_currentTab, duration: Duration(milliseconds: 100), curve: Curves.linear);
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
                                      'Adopt',
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: _currentTab == 0
                                              ? greenAccent
                                              : greenPrimary),
                                    )
                                  ]),
                            ),
                        ),
                        Container(
                          width: width * 0.20,
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                _currentTab = 1;
                                _myPage.animateToPage(_currentTab, duration: Duration(milliseconds: 100), curve: Curves.linear);
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
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _currentTab == 1
                                            ? greenAccent
                                            : greenPrimary),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width * 0.20,
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                _currentTab = 2;
                                _myPage.animateToPage(_currentTab, duration: Duration(milliseconds: 100), curve: Curves.linear);
                              });
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.store_mall_directory,
                                      color: _currentTab == 2
                                          ? greenAccent
                                          : greenPrimary),
                                  Text(
                                    'Shelter',
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _currentTab == 2
                                            ? greenAccent
                                            : greenPrimary),
                                  )
                                ]),
                          ),
                        ),
                        Container(
                          width: width * 0.20,
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                _currentTab = 3;
                                _myPage.animateToPage(_currentTab, duration: Duration(milliseconds: 100), curve: Curves.linear);
                              });
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.account_circle,
                                      color: _currentTab == 3
                                          ? greenAccent
                                          : greenPrimary),
                                  Text(
                                    'Account',
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _currentTab == 3
                                            ? greenAccent
                                            : greenPrimary),
                                  )
                                ]),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: keyboardIsUp ? null : FloatingActionButton(
            onPressed: () {
              Navigator.push(context,  MaterialPageRoute(
                  builder: (context) => PublishDisappearanceScreen()));
            },
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 105, 198, 133),
          ),
        ),
        onWillPop: _onBackPressed
    );
  }
}

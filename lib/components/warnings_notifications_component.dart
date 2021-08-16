import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SuccessWarning extends StatefulWidget {
  final String successText;
  final int duration;

  const SuccessWarning({Key key, this.successText, this.duration})
      : super(key: key);

  @override
  _SuccessWarningState createState() => _SuccessWarningState();
}

class _SuccessWarningState extends State<SuccessWarning> {
  double startPos = -1.0;
  double endPos = 0.0;
  Curve curve = Curves.easeIn;

  bool safeArea(double padding) {
    if (padding > 0)
      return true;
    else
      return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);

    var padding = MediaQuery.of(context).viewPadding.top;

    return TweenAnimationBuilder(
      tween:
          Tween<Offset>(begin: Offset(0.0, startPos), end: Offset(0.0, endPos)),
      duration: Duration(seconds: 1),
      curve: curve,
      builder: (context, offset, child) {
        return FractionalTranslation(
          translation: offset,
          child: Container(
            height: 20,
            child: child,
          ),
        );
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
            color: greenPrimary,
            width: double.infinity,
            child: Padding(
                padding: (safeArea(padding))
                    ? EdgeInsets.only(top: 32)
                    : EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.info, size: 45, color: Colors.white),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(widget.successText,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.none)),
                      )
                    ],
                  ),
                ))),
      ),
      onEnd: () {
        Timer(Duration(seconds: widget.duration), () {
          curve =
              curve == Curves.easeInBack ? Curves.easeOutBack : Curves.easeIn;
          if (startPos == -1) {
            setState(() {
              startPos = 0.0;
              endPos = -1.0;
            });
          }
        });
      },
    );
  }
}

class InfoWarning extends StatefulWidget {
  final String infoText;
  final int duration;

  const InfoWarning({Key key, this.infoText, this.duration}) : super(key: key);

  @override
  _InfoWarningState createState() => _InfoWarningState();
}

class _InfoWarningState extends State<InfoWarning> {
  double startPos = -1.0;
  double endPos = 0.0;
  Curve curve = Curves.easeIn;

  @override
  void initState() {
    super.initState();
  }

  bool safeArea(double padding) {
    if (padding > 0)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).viewPadding.top;

    return TweenAnimationBuilder(
      tween:
          Tween<Offset>(begin: Offset(0.0, startPos), end: Offset(0.0, endPos)),
      duration: Duration(seconds: 1),
      curve: curve,
      builder: (context, offset, child) {
        return FractionalTranslation(
          translation: offset,
          child: Container(
            height: 20,
            child: child,
          ),
        );
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
            color: Colors.blue,
            width: double.infinity,
            child: Padding(
                padding: (safeArea(padding))
                    ? EdgeInsets.only(top: 32)
                    : EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.info, size: 45, color: Colors.white),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(widget.infoText,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.none)),
                      )
                    ],
                  ),
                ))),
      ),
      onEnd: () {
        Timer(Duration(seconds: widget.duration), () {
          curve =
              curve == Curves.easeInBack ? Curves.easeOutBack : Curves.easeIn;
          if (startPos == -1) {
            setState(() {
              startPos = 0.0;
              endPos = -1.0;
            });
          }
        });
      },
    );
  }
}

class DangerWarning extends StatefulWidget {
  final String dangerText;
  final int duration;

  const DangerWarning({Key key, this.dangerText, this.duration})
      : super(key: key);

  @override
  _DangerWarningState createState() => _DangerWarningState();
}

class _DangerWarningState extends State<DangerWarning> {
  double startPos = -1.0;
  double endPos = 0.0;
  Curve curve = Curves.easeIn;

  @override
  void initState() {
    super.initState();
  }

  bool safeArea(double padding) {
    if (padding > 0)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).viewPadding.top;

    return TweenAnimationBuilder(
      tween:
          Tween<Offset>(begin: Offset(0.0, startPos), end: Offset(0.0, endPos)),
      duration: Duration(seconds: 1),
      curve: curve,
      builder: (context, offset, child) {
        return FractionalTranslation(
          translation: offset,
          child: Container(
            height: 20,
            child: child,
          ),
        );
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
            color: Colors.red,
            width: double.infinity,
            child: Padding(
                padding: (safeArea(padding))
                    ? EdgeInsets.only(top: 32)
                    : EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.info, size: 45, color: Colors.white),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(widget.dangerText,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.none)),
                      )
                    ],
                  ),
                ))),
      ),
      onEnd: () {
        Timer(Duration(seconds: widget.duration), () {
          curve =
              curve == Curves.easeInBack ? Curves.easeOutBack : Curves.easeIn;
          if (startPos == -1) {
            setState(() {
              startPos = 0.0;
              endPos = -1.0;
            });
          }
        });
      },
    );
  }
}

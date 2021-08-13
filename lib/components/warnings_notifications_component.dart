import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WarningNotification extends StatefulWidget {
  final String warningText;
  final int duration;

  const WarningNotification({Key key, this.warningText, this.duration})
      : super(key: key);

  @override
  _WarningNotificationState createState() => _WarningNotificationState();
}

class _WarningNotificationState extends State<WarningNotification> {
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
    final Color greenLight = Color.fromARGB(255, 197, 234, 117);
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
            color: greenLight,
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
                      Icon(Icons.info, size: 45, color: greenPrimary),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(widget.warningText,
                            style: TextStyle(
                                color: Colors.black87,
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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
final Color greenAccent = Color.fromARGB(255, 24, 157, 139);

class ImageNotDefineAlert extends StatelessWidget {
  String _title;
  String _content;

  ImageNotDefineAlert({String title, String content}) {
    this._title = title;
    this._content = content;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(children: [
        Icon(
          Icons.info_rounded,
          size: 29,
          color: greenAccent,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            this._title,
            style: TextStyle(fontFamily: 'Quicksand', color: greenAccent),
          ),
        )
      ]),
      content: Text(
        this._content,
        style: TextStyle(fontFamily: 'Quicksand'),
      ),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(
              'Ok',
              style: TextStyle(fontFamily: 'Quicksand', color: greenPrimary),
            ))
      ],
    );
  }
}

class SuccessPublish extends StatelessWidget {
  String _title;
  String _content;

  SuccessPublish({String title, String content}) {
    _title = title;
    _content = content;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(children: [
        Icon(
          Icons.check_circle,
          size: 29,
          color: greenPrimary,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            this._title,
            style: TextStyle(fontFamily: 'Quicksand', color: greenPrimary),
          ),
        )
      ]),
      content: Text(
        this._content,
        style: TextStyle(fontFamily: 'Quicksand'),
      ),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pop(context, true);
            },
            child: Text(
              'Ok',
              style: TextStyle(fontFamily: 'Quicksand', color: greenPrimary),
            ))
      ],
    );
  }
}

class ErrorPublish extends StatelessWidget {
  String _title;
  String _content;

  ErrorPublish({String title, String content}) {
    _title = title;
    _content = content;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(children: [
        Icon(
          Icons.error,
          size: 29,
          color: Colors.redAccent,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            this._title,
            style: TextStyle(fontFamily: 'Quicksand', color: Colors.redAccent),
          ),
        )
      ]),
      content: Text(
        this._content,
        style: TextStyle(fontFamily: 'Quicksand'),
      ),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(
              'Ok',
              style: TextStyle(fontFamily: 'Quicksand', color: greenPrimary),
            ))
      ],
    );
  }
}

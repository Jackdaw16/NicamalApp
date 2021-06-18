import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      title: Text(
        this._title,
        style: TextStyle(fontFamily: 'Quicksand'),
      ),
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
              style: TextStyle(fontFamily: 'Quicksand'),
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
      title: Text(
        this._title,
        style: TextStyle(fontFamily: 'Quicksand'),
      ),
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
              style: TextStyle(fontFamily: 'Quicksand'),
            ))
      ],
    );
  }
}

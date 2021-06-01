import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class ImageDialog extends StatefulWidget {
  final String urlImage;

  const ImageDialog({Key key, this.urlImage}) : super(key: key);

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 300,
          child: PhotoView(
            imageProvider: NetworkImage(widget.urlImage),
            loadingBuilder: (context, progress) => Center(
              child: CircularProgressIndicator(),
            ),
            maxScale: PhotoViewComputedScale.covered * 1.8,
            minScale: PhotoViewComputedScale.contained * 0.8,
            initialScale: PhotoViewComputedScale.contained * 1.1,
            backgroundDecoration: BoxDecoration(color: Colors.transparent),
          ),
        ));
  }
}
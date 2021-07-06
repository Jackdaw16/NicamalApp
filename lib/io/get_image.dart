import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:nicamal_app/io/iimage_picker.dart';

class GetImage implements IImagePicker {
  @override
  Future<PickedFile> getImageFromCamera() async {
    PickedFile _image = await ImagePicker().getImage(source: ImageSource.camera);

    return _image;
  }

  @override
  Future<PickedFile> getImageFromGallery() async {
    PickedFile _image = await ImagePicker().getImage(source: ImageSource.gallery);

    return _image;
  }

}
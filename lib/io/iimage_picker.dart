import 'package:image_picker/image_picker.dart';

abstract class IImagePicker {
  Future<PickedFile> getImageFromCamera();
  Future<PickedFile> getImageFromGallery();
}
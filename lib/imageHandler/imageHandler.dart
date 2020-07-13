import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:teamrapport/login/loginScreen.dart';

import '../constants.dart';

class ImageHandler {

  File file;
  Future<File> handleTakePhoto(BuildContext context) async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    File tempFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
      file = tempFile;
      File outputFile = await compressImage();
      return outputFile;
  }

  Future<File> handleChooseFromGallery(BuildContext context) async {
    Navigator.pop(context);
    File tempFile =
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery);
      file = tempFile;
      return await compressImage();
  }


  Future<File> compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$myNumber.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    file = compressedImageFile;
    return file;
  }
}
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:teamrapport/login/loginScreen.dart';
import '../checkUser.dart';


class ImageHandler {


  Future<File> compressImage(File file) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$myNumber.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 60));
    file = compressedImageFile;
    return file;
  }

  handleImage(File file,String name) async {
    File compressedFile = await compressImage(file);
    String mediaUrl = await uploadImage(compressedFile,name);
    return mediaUrl;
  }

  Future<String> uploadImage(imageFile,name) async {
    StorageUploadTask uploadTask =
    storageRef.child('$myNumber/$name.jpg').putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

}

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:teamrapport/login/loginScreen.dart';
import '../checkUser.dart';
import '../constants.dart';

class StudentInfo extends StatefulWidget {
  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  String firstName = ' ', lastName = ' ', email = ' ', mediaUrl = ' ';
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  File file;

  @override
  void initState() {
    mobileNoController.text = myNumber;
    countryController.text = 'India';
    super.initState();
  }

  Future<void> getUserLocation() async {
    try {
      GeolocationStatus geolocationStatus =
          await Geolocator().checkGeolocationPermissionStatus();
      print(geolocationStatus);
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placeMarks = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placeMark = placeMarks[0];
      cityController.text = placeMark.subAdministrativeArea;
      stateController.text = placeMark.administrativeArea;
      pincodeController.text = placeMark.postalCode;
    } catch (e) {
      print(e);
    }
  }

  handleTakePhoto() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    File file = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      this.file = file;
    });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    File file =
        // ignore: deprecated_member_use
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.file = file;
    });
  }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          elevation: 50,
          backgroundColor: Color(0xFF424242),
          //contentPadding: EdgeInsets.all(20.0),
          titlePadding: EdgeInsets.only(top: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Center(
              child: Text(
            'Upload Profile Picture',
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          )),
          children: <Widget>[
            SimpleDialogOption(
              child: Row(
                children: <Widget>[
                  Icon(
                    CupertinoIcons.photo_camera,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Photo with Camera',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                ],
              ),
              onPressed: handleTakePhoto,
            ),
            SimpleDialogOption(
              onPressed: handleChooseFromGallery,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Image from Gallery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                ],
              ),
            ),
            SimpleDialogOption(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                ],
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$myNumber.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  handleImage() async {
    setState(() {});
    await compressImage();
    mediaUrl = await uploadImage(file);
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask =
        storageRef.child('post_$myNumber.jpg').putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  createFirebase() async {
    await handleImage();
    DocumentReference docRef = usersRef.document(myNumber);
    await docRef.setData({
      'isTeacher': false,
      'firstName': firstName,
      'lastName': lastName,
      'Name': firstName + ' ' + lastName,
      'profilePic': mediaUrl,
      'mobileNumber': myNumber,
      'email': email,
      'country': countryController.text,
      'state': stateController.text,
      'city': cityController.text,
      'pincode': pincodeController.text,
    });
    Navigator.pop(context);
    setState(() {
      file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Incomplete Page Just go back',
                    style: kTextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {
                        selectImage(context);
                      },
                      child: file == null
                          ? CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 40,
                            )
                          : Card(
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Image.file(file),
                              ),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListTile(
                            title: TextFormField(
                              onChanged: (val) {
                                firstName = val;
                              },
                              decoration: InputDecoration(
                                  hintText: 'First Name',
                                  hintStyle: kLabelStyle,
                                  focusedBorder: kTextInputBorder,
                                  enabledBorder: kTextInputBorder,
                                  labelStyle: kLabelStyle,
                                  labelText: 'First Name'),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListTile(
                            title: TextFormField(
                              onChanged: (val) {
                                lastName = val;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Last Name',
                                  hintStyle: kLabelStyle,
                                  focusedBorder: kTextInputBorder,
                                  enabledBorder: kTextInputBorder,
                                  labelStyle: kLabelStyle,
                                  labelText: 'Last Name'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /*


                  Gender and DOB will Come here.


                   */
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListTile(
                      title: TextFormField(
                        controller: mobileNoController,
                        decoration: InputDecoration(
                            prefixText: 'Mobile No : ',
                            hintText: 'Mobile No',
                            hintStyle: kLabelStyle,
                            focusedBorder: kTextInputBorder,
                            enabledBorder: kTextInputBorder,
                            labelStyle: kLabelStyle,
                            labelText: 'Mobile No'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListTile(
                      title: TextFormField(
                        onChanged: (val) {
                          email = val;
                        },
                        decoration: InputDecoration(
                            prefixText: 'Email : ',
                            hintText: 'Email',
                            hintStyle: kLabelStyle,
                            focusedBorder: kTextInputBorder,
                            enabledBorder: kTextInputBorder,
                            labelStyle: kLabelStyle,
                            labelText: 'Email'),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListTile(
                            title: TextFormField(
                              controller: countryController,
                              decoration: InputDecoration(
                                  hintText: 'Country',
                                  hintStyle: kLabelStyle,
                                  focusedBorder: kTextInputBorder,
                                  enabledBorder: kTextInputBorder,
                                  labelStyle: kLabelStyle,
                                  labelText: 'Country'),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListTile(
                            title: TextFormField(
                              controller: stateController,
                              decoration: InputDecoration(
                                  hintText: 'State',
                                  hintStyle: kLabelStyle,
                                  focusedBorder: kTextInputBorder,
                                  enabledBorder: kTextInputBorder,
                                  labelStyle: kLabelStyle,
                                  labelText: 'State'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListTile(
                            title: TextFormField(
                              controller: cityController,
                              decoration: InputDecoration(
                                  hintText: 'City',
                                  hintStyle: kLabelStyle,
                                  focusedBorder: kTextInputBorder,
                                  enabledBorder: kTextInputBorder,
                                  labelStyle: kLabelStyle,
                                  labelText: 'City'),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListTile(
                            title: TextFormField(
                              controller: pincodeController,
                              decoration: InputDecoration(
                                  hintText: 'Pincode',
                                  hintStyle: kLabelStyle,
                                  focusedBorder: kTextInputBorder,
                                  enabledBorder: kTextInputBorder,
                                  labelStyle: kLabelStyle,
                                  labelText: 'Pincode'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: FlatButton.icon(
                        onPressed: () {
                          getUserLocation();
                        },
                        icon: Icon(
                          Icons.my_location,
                          color: Colors.blue,
                        ),
                        label: Text(
                          'Get Location',
                          style: kTextStyle,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: FlatButton.icon(
                        onPressed: () {
                          createFirebase();
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                        label: Text(
                          'Next',
                          style: kTextStyle,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

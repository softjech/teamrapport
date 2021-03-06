/*
        Some code have been removed because of some security purpose.
* */

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:teamrapport/loading/progress.dart';
import 'package:teamrapport/login/loginScreen.dart';
import '../checkUser.dart';
import '../constants.dart';
import 'student_home_screen.dart';

class StudentInfo extends StatefulWidget {
  static const String studentRoute = '/onboarding/login/student';

  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  String _firstName;
  String _lastName;
  String _emailId;
  String _highestEducation;
  String _mediaUrl = ' ';

  //Input form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  File file;
  bool isLoading = false;

  @override
  void initState() {
    getUserLocation();
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
          backgroundColor: Colors.white,
          //contentPadding: EdgeInsets.all(20.0),
          titlePadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Text(
              'Upload Profile Picture',
              style: heading2,
            ),
          ),
          children: <Widget>[
            SimpleDialogOption(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.camera_alt,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'From Camera',
                    style: subhead2,
                  ),
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
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'From Gallery',
                    style: subhead2,
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              alignment: Alignment.center,
              child: GestureDetector(
                child: Text(
                  'Cancel',
                  style: subhead2.copyWith(
                    fontSize: 14,
                    color: themeColor,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
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
    _mediaUrl = await uploadImage(file);
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask =
        storageRef.child('post_$myNumber.jpg').putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  createFirebase() async {
    setState(() {
      isLoading = true;
    });
    if (file != null) {
      await handleImage();
    }
    List<String> myData = [
      'false',
      _firstName,
      _lastName,
      _emailId,
      myNumber,
      countryController.text,
      stateController.text,
      cityController.text,
      pincodeController.text,
      _mediaUrl
    ];
    DocumentReference docRef = usersRef.document(myNumber);
    await docRef.setData({
      'isTeacher': false,
      'education': _highestEducation,
      'firstName': _firstName,
      'lastName': _lastName,
      'Name': _firstName + ' ' + _lastName,
      'profilePic': _mediaUrl,
      'mobileNumber': myNumber,
      'email': _emailId,
      'country': countryController.text,
      'state': stateController.text,
      'city': cityController.text,
      'pincode': pincodeController.text,
    });
    setState(() {
      isLoading = false;
      file = null;
    });
    Navigator.pushReplacementNamed(context, StudentHomeScreen.routeName);
  }

  Widget _getProfilePic() {
    return Material(
      elevation: 10,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Center(
        child: GestureDetector(
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.15,
            backgroundImage: file != null
                ? FileImage(file)
                : AssetImage(
                    'assets/images/default.png',
                  ),
            backgroundColor: Colors.transparent,
          ),
          onTap: () {
            //Implement setting up of profile Image here.
            selectImage(context);
          },
        ),
      ),
    );
  }

  Widget _buildFirstName() {
    return myFromField(
      label: 'First Name',
      validator: (String value) {
        if (value.isEmpty) {
          return 'First name is required';
        }
        return null;
      },
      onSaved: (String value) {
        _firstName = value;
      },
    );
  }

  Widget _buildLastName() {
    return myFromField(
      label: 'Last Name',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last name is required.';
        }
        return null;
      },
      onSaved: (String value) {
        _lastName = value;
      },
    );
  }

  Widget _buildHighestEducation() {
    return myFromField(
      label: 'Highest Education',
      hint: 'ABC degree from XYZ university.',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Education details are required.';
        }

        return null;
      },
      onSaved: (String value) {
        _highestEducation = value;
      },
    );
  }

  Widget _buildEmail() {
    return myFromField(
      label: 'Email Address',
      hint: 'someone@example.com',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required.';
        }
        if (!RegExp(
                r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')
            .hasMatch(value)) {
          return 'invalid email address';
        }
        return null;
      },
      onSaved: (String value) {
        _emailId = value;
      },
    );
  }

  Widget _buildCountry() {
    return myFromField(
      label: 'Country',
      controller: countryController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Country is required.';
        }

        return null;
      },
    );
  }

  Widget _buildState() {
    return myFromField(
      label: 'State',
      controller: stateController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'State is required.';
        }

        return null;
      },
    );
  }

  Widget _buildCity() {
    return myFromField(
      label: 'City',
      controller: cityController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'City is required.';
        }

        return null;
      },
    );
  }

  Widget _buildPincode() {
    return myFromField(
      label: 'PIN Code',
      controller: pincodeController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'PIN code is required.';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? circularProgress()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    CheckUser.checkRoute,
                  );
                },
              ),
              title: Text(
                'Student Profile',
                style: heading1,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    _getProfilePic(),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: _buildFirstName(),
                        ),
                        Expanded(
                          child: _buildLastName(),
                        ),
                      ],
                    ),
                    /*


                    Gender and DOB will Come here.


                     */
                    _buildEmail(),
                    _buildHighestEducation(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        'Enter the details of the education you are currently pursuing.',
                        style: subhead1,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: _buildCountry(),
                        ),
                        Expanded(child: _buildState()),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: _buildCity(),
                        ),
                        Expanded(
                          child: _buildPincode(),
                        ),
                      ],
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        getUserLocation();
                      },
                      icon: Icon(
                        Icons.my_location,
                        color: Colors.blue,
                      ),
                      label: Text(
                        'Use current Location',
                        style: subhead2,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    myRaisedButton(
                      label: 'Next',
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();
                        print(_firstName + " " + _lastName);
                        print(_highestEducation);
                        print(_emailId);
                        createFirebase();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

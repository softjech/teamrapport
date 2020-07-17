import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamrapport/imageHandler/imageHandler.dart';
import 'package:teamrapport/loading/progress.dart';
import 'package:teamrapport/login/loginScreen.dart';
import 'package:teamrapport/teacher/teacherHome.dart';

import '../constants.dart';


final verificationRef = Firestore.instance.collection('aadharVerification');


class TeacherVerification extends StatefulWidget {
  static const String routeName =
      '/login/checkUser/personalDetails/professionalDetails/addressDetails/teacherVerification';

  @override
  _TeacherVerificationState createState() => _TeacherVerificationState();

/*
  This screen is only shown in case of Home tutor
   */
}

class _TeacherVerificationState extends State<TeacherVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _aadharNumber;
  File front,back;
  bool isLoading = false;


  handleTakePhoto(String title) async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    File file = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      title=='front' ? this.front = file:this.back = file;
    });
  }

  handleChooseFromGallery(String title) async {
    Navigator.pop(context);
    File file =
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      title=='front' ? this.front = file:this.back = file;
    });
  }

  selectImage(parentContext,String title) {
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
              onPressed: (){
                handleTakePhoto(title);},
            ),
            SimpleDialogOption(
              onPressed: (){
                handleChooseFromGallery(title);
              },
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

  createFirebase() async {
    String frontUrl=' ';
    String backUrl=' ';
    setState(() {
      isLoading = true;
    });
    if (front != null) {
      frontUrl = await ImageHandler().handleImage(front,'aadharFront');
      if(back != null) {
        backUrl = await ImageHandler().handleImage(back, 'aadharBack');
      }
    }
    DocumentReference docRef = verificationRef.document(myNumber);
    await docRef.setData({
      'aadharNo':_aadharNumber,
      'aadharFrontUrl':frontUrl,
      'aadharBackUrl':backUrl,
    });
    Navigator.of(context).pushReplacementNamed(TeacherHomeScreen.routeName);
    setState(() {
      isLoading = false;
    });
  }


  Widget _buildAadhar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        maxLengthEnforced: true,
        maxLength: 10,
        decoration: myInputDecoration(label: 'Aadhar Number'),
        validator: (String value) {
          if (value.isEmpty) return 'Aadhar number required';
          if (value.length < 10) return 'Invalid Aadhar number';
          return null;
        },
        onSaved: (String value) {
          _aadharNumber = int.tryParse(value);
        },
      ),
    );
  }

  Widget _buildAadharImage() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add image of your Aadhar Card\'s front',
              style: subhead2.copyWith(fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectImage(context, 'front');
            },
            child: Container(
              padding: const EdgeInsets.all(8.9),
              height: MediaQuery.of(context).size.height * 0.28,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black38)),
              child: front != null
                  ? Image(image:FileImage(front))
                  : Image.asset(
                      'assets/images/aadhar_placeholder_front.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add image of your Aadhar Card\'s back',
              style: subhead2.copyWith(fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectImage(context, 'back');
            },
            child: Container(
              padding: const EdgeInsets.all(8.9),
              height: MediaQuery.of(context).size.height * 0.28,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black38)),
              child: back != null
                  ? Image(image:FileImage(back))
                  : Image.asset(
                      'assets/images/aadhar_placeholder_back.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? circularProgress() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Verification',
          style: heading1.copyWith(fontSize: 24),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.center,
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'As per our policy you need to verify yourself by providing your Aadhar card details. Read here',
                  style: subhead2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildAadhar(),
              _buildAadharImage(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Rapport will never share your Aadhar card details to any of its users or third party platforms.',
                  style: subhead2.copyWith(color: Colors.redAccent),
                ),
              ),

              //-------End of form-------
              SizedBox(
                height: 30,
              ),
              myRaisedButton(
                label: 'Next',
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  createFirebase();
//                  print(widget._firstName + " " + widget._lastName);
//                  print(widget._popularName);
//                  print(widget._emailId);
//                  print(widget._sex);
//                  print(widget._aadharNumber);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

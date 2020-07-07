import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:teamrapport/UserInfo/studentInfo.dart';
import 'package:teamrapport/home/homeScreen.dart';
import 'package:teamrapport/login/loginScreen.dart';
import 'package:teamrapport/saveDataLocally/sharedPrefFunctions.dart';

import 'loading/progress.dart';

final usersRef = Firestore.instance.collection('users');
final StorageReference storageRef = FirebaseStorage.instance.ref();
bool isLoading = true;
bool dataExists = false;

class CheckUser extends StatefulWidget {
  static const String checkRoute = '/login/checkUser';
  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    checkUser();
    super.initState();
  }

  checkUser() async {
    myNumber = await SharedPrefFunction().getNumberPreference();
    DocumentSnapshot doc = await usersRef.document(myNumber).get();
    if (doc.exists) {
      setState(() {
        dataExists = true;
        isLoading = false;
      });
    } else {
      setState(() {
        dataExists = false;
        isLoading = false;
      });
    }
  }

  homePage(BuildContext context) {
    if (dataExists) {
      return Navigator.of(context).pushReplacementNamed(HomeScreen.homeRoute);
    } else {
      return getInfoPage();
    }
  }

  getInfoPage() {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Who are you?'),
                SizedBox(
                  height: 40,
                ),
                RaisedButton(
                  child: Text('Teacher'),
                  onPressed: () {
                    print('Teacher');
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Student'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StudentInfo();
                    }));
                    setState(() {
                      dataExists = true;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? circularProgress() : homePage(context);
  }
}

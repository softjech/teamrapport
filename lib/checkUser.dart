import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamrapport/home/homeScreen.dart';
import 'package:teamrapport/student/studentInfo.dart';
import 'package:teamrapport/login/loginScreen.dart';
import 'package:teamrapport/saveDataLocally/sharedPrefFunctions.dart';
import 'package:teamrapport/teacher/teacherDetails.dart';
import 'package:teamrapport/widgets/boxWidget.dart';
import 'AuthService.dart';
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
    //DocumentSnapshot doc = await usersRef.document(myNumber).get();
    if (myNumber != null) {
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
      return Scaffold(
        body: SafeArea(
          child: Container(
            child: FlatButton.icon(
              onPressed: () {
                setState(() {
                  AuthService().signOut();
                });
              },
              icon: Icon(Icons.clear),
              label: Text('Sign Out'),
            ),
          ),
        ),
      );
    } else {
      return getInfoPage();
    }
  }

  getInfoPage() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/images/bg_diary.png',
                    width: size.width * 0.8,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Who are you?',
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal:10.0),
//                      child: Text(
//                        'You can use Rapport as a Student or as a teacher.',
//                        style: subhead2,
//                      ),
//                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        BoxWidget(
                          title: 'Teacher',
                          onTap: () {
                            Navigator.pushNamed(
                                context, TeacherDetailsScreen.teacherDetailsRoute);
                          },
                          desc: 'Reach out to new students.',
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        BoxWidget(
                          title: 'Student',
                          onTap: () {
                            Navigator.pushNamed(
                                context, StudentInfo.studentRoute);
                          },
                          desc: 'Rate teachers and find the best for you.',
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
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

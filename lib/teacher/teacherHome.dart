import 'package:flutter/material.dart';


class TeacherHomeScreen extends StatefulWidget {
  static const String routeName = '/login/checkUser/personalDetails/professionalDetails/addressDetails/teacherHome';
  @override
  _TeacherHomeScreenState createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Ramesh'),
      ),
    );
  }
}

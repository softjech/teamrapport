import 'package:flutter/material.dart';
import 'package:teamrapport/AuthService.dart';


class HomeScreen extends StatefulWidget {
  static const String homeRoute = '/onboarding/login/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
  }
}


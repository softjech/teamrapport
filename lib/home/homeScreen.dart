import 'package:flutter/material.dart';
import 'package:teamrapport/AuthService.dart';

class HomeScreen extends StatelessWidget {
  static const String homeRoute = '/onboarding/login/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FlatButton.icon(
            onPressed: () {
              AuthService().signOut();
            },
            icon: Icon(Icons.clear),
            label: Text('Sign Out'),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamrapport/AuthService.dart';


class HomeScreen extends StatelessWidget {
  static const String homeRoute = '/onboarding/login/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatButton(onPressed: (){AuthService.signOut();}, child: Text('Sign out'),),
    );
  }
}

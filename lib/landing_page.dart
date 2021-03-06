/*
        Some code have been removed because of some security purpose.
* */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamrapport/checkUser.dart';
import 'package:teamrapport/loading/progress.dart';
import 'package:teamrapport/login/loginScreen.dart';
import 'package:teamrapport/services/auth.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return LoginScreen();
            } else {
              Navigator.maybePop(context);
              return CheckUser();
            }
          } else {
            return Scaffold(
              body: Center(
                child: circularProgress(),
              ),
            );
          }
        });
  }
}

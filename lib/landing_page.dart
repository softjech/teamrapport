import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamrapport/checkUser.dart';
import 'package:teamrapport/loading/progress.dart';
import 'package:teamrapport/login/loginScreen.dart';
import 'package:teamrapport/saveDataLocally/sharedPrefFunctions.dart';
import 'package:teamrapport/services/auth.dart';
import 'package:teamrapport/services/auth_provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.of(context);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return LoginScreen();
            }
            else{
              SharedPrefFunction().saveLoginPreference();
              Navigator.maybePop(context);
            return CheckUser();}
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

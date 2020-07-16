import 'package:flutter/material.dart';
import 'package:teamrapport/student/student_home_screen.dart';
import 'package:teamrapport/widgets/onBoardingScreen.dart';
import 'auth.dart';

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.
class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot,this.dataExists,this.isLogin}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;
  final String isLogin;
  final bool dataExists;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      if(isLogin == null){
        return OnboardingScreen();
      }
      else{
        if(dataExists){
          return StudentHomeScreen();
        }
        //return userSnapshot.hasData ? CheckUser(dataExist: dataExists,) : LoginScreen();
      }
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

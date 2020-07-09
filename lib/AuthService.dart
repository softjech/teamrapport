import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamrapport/checkUser.dart';
import 'package:teamrapport/login/loginScreen.dart';
import 'package:teamrapport/saveDataLocally/sharedPrefFunctions.dart';
import 'package:teamrapport/widgets/onBoardingScreen.dart';
import 'main.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
//          if (isLogin == null) {
//            return OnboardingScreen();
//          }
          if (snapshot.hasData) {
            Navigator.maybePop(context);
            SharedPrefFunction().saveLoginPreference();
            return CheckUser();
          }
          else{
          return LoginScreen();}
        });
  }

  signInWithOtp(smsCode, verId, context) {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCredential);
    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        Navigator.popAndPushNamed(context, CheckUser.checkRoute);
      }
    });
  }

  signIn(AuthCredential authCredential) {
    FirebaseAuth.instance.signInWithCredential(authCredential);
  }

  signOut() {
    SharedPrefFunction().saveLogoutPreference();
    FirebaseAuth.instance.signOut();
  }
}

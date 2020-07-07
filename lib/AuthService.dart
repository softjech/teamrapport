import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamrapport/checkUser.dart';
import 'package:teamrapport/login/loginScreen.dart';
import 'package:teamrapport/saveDataLocally/sharedPrefFunctions.dart';
import 'package:teamrapport/widgets/onBoardingScreen.dart';
import 'main.dart';
//import 'package:teamrapport/home/homeScreen.dart';
//import 'package:teamrapport/widgets/onBoardingScreen.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          print(isLogin.toString() + 'isLogin');
          if (isLogin == null) {
            return OnboardingScreen();
          } else if (snapshot.hasData) {
            Navigator.maybePop(context);
            SharedPrefFunction().saveLoginPreference();
            return CheckUser();
          }
          return LoginScreen();
        });
  }

  signInWithOtp(smsCode, verId) {
    print('signInwithOtp');
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    print('Hello   ' + authCredential.toString());
    signIn(authCredential);
  }

  signIn(AuthCredential authCredential) {
    print('signIn ' + authCredential.toString());
    FirebaseAuth.instance.signInWithCredential(authCredential);
//    handleAuth();
  }

  signOut() {
    SharedPrefFunction().saveLogoutPreference();
    FirebaseAuth.instance.signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamrapport/home/homeScreen.dart';
import 'package:teamrapport/widgets/onBoardingScreen.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return OnboardingScreen();
          }
        });
  }

  signInWithOtp(smsCode, verId) {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCredential);
  }

  signIn(AuthCredential authCredential) {
    FirebaseAuth.instance.signInWithCredential(authCredential);
//    handleAuth();
    print(authCredential);
  }

  static signOut() {
    FirebaseAuth.instance.signOut();
  }
}

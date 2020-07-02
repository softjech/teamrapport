import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamrapport/login/loginScreen.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Container(
                child: FlatButton.icon(onPressed: signOut, icon: Icon(Icons.clear),label: Text('Sign Out'),),
              ),
            );
          } else {
            return LoginScreen();
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
    print(authCredential);
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}

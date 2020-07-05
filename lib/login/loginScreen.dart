import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamrapport/saveDataLocally/sharedPrefFunctions.dart';
import '../AuthService.dart';
import '../constants.dart';

String number, otp;
String myNumber = ' ';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String otp, smsCode;
  TextEditingController code = TextEditingController();
  bool codeSent = false;
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: orientation == Orientation.portrait
                        ? (size.height / 2) - 150
                        : (size.height / 2) - 90,
                    left: orientation == Orientation.portrait
                        ? (size.width / 2) - 50
                        : (size.width / 2) - 45,
                    child: Container(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'DM Mono',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: orientation == Orientation.portrait
                        ? (size.height / 2) - 80
                        : (size.height / 2) - 40,
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        onChanged: (values) {
                          number = values;
                        },
                        decoration: InputDecoration(
                          hintText: '7123456789',
                          hintStyle: TextStyle(fontFamily: 'DM Mono'),
                          enabledBorder: kTextInputBorder,
                          focusedBorder: kTextInputBorder,
                          prefixIcon: Icon(
                            Icons.phone_android,
                            color: Colors.black,
                          ),
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'DM Mono',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: orientation == Orientation.portrait
                        ? (size.height / 2)
                        : (size.height / 2) + 40,
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        onChanged: (value) {
                          smsCode = value;
                        },
                        controller: code,
                        decoration: InputDecoration(
                          hintText: 'OTP',
                          hintStyle: TextStyle(fontFamily: 'DM Mono'),
                          enabledBorder: kTextInputBorder,
                          focusedBorder: kTextInputBorder,
                          prefixIcon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          labelText: 'OTP',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'DM Mono',
                              fontWeight: FontWeight.bold),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: orientation == Orientation.portrait
                        ? (size.height / 2) - 130
                        : (size.height / 2) - 170,
                    left: orientation == Orientation.portrait
                        ? (size.width / 2) - 50
                        : (size.width / 2) - 45,
                    child: FlatButton(
                      onPressed: () {
                        codeSent
                            ? AuthService().signInWithOtp(smsCode, otp)
                            : verify(number);
                      },
                      child: Text(
                        codeSent ? 'Verify' : 'Get OTP',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'DM Mono',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //Code to verify number
  Future<void> verify(phoneNo) async {
    phoneNo = '+91' + phoneNo;
    myNumber = phoneNo;
    SharedPrefFunction().saveNumberPreference(myNumber);
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print('${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.otp = verId;
      setState(() {
        codeSent = true; //In case number is not in the mobile
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.otp = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}

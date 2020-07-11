import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
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
  static const String loginRoute = '/onboarding/login';
}

class _LoginScreenState extends State<LoginScreen> {
  String otp, smsCode;
  TextEditingController code = TextEditingController();
  bool codeSent = false;
  Image logo;

  @override
  void initState() {
    super.initState();
    logo = Image.asset(
      "assets/images/logo_blue.png",
      height: 60,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
//    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          MediaQuery.of(context).viewInsets.bottom == 0
              ? Positioned(
                  bottom: 0,
                  child: Image.asset(
                    'assets/images/bg_book_plant.jpg',
                    width: size.width,
                    fit: BoxFit.fitWidth,
                  ),
                )
              : Container(),
          Positioned(
            bottom: 0,
            child: Container(
              height: 300,
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [Colors.white, Colors.white.withOpacity(0)],
                ),
              ),
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: size.height / 9,
                      ),
                      Card(
                        child: logo,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Login',
                        style: GoogleFonts.montserrat(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Welcome',
                        style: GoogleFonts.raleway(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
//                      style: TextStyle(
//                        fontSize: 24,
//                        fontFamily: 'Montserrat',
//                        fontWeight: FontWeight.w300,
//                      ),
                      ),
                      const Text(
                        'Sign in to continue with your mobile number.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 2,
                              child: TextField(
                                controller: TextEditingController()
                                  ..text = '+91',
                                readOnly: true,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(15),
                                  enabledBorder: leftTextInputBorder,
                                  focusedBorder: leftTextInputBorder,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 8,
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                onChanged: (values) {
                                  number = values;
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(15),
                                  enabledBorder: rightTextInputBorder,
                                  focusedBorder: rightTextInputBorder,
                                  labelText: 'Mobile Number',
                                  labelStyle: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Rapport will send a 6 digit OTP via SMS to verify your phone number.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      myRaisedButton(
                        label: 'Get OTP',
                        onPressed: () {
                          createAlertDialog(context);
//                            codeSent
//                                ? AuthService()
//                                    .signInWithOtp(smsCode, otp, context)
//                                : verify(number);
                          AuthService().signInWithOtp(smsCode, otp, context);
                          verify(number);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  //Function to create pop-up menu here
  createAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
//          verify(number);
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: EdgeInsets.all(15),
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Enter the OTP received.',
                      style: heading2,
                    ),
                  ),
                ),
                TextField(
                  controller: code,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(15),
                    enabledBorder: completeInputBorder,
                    focusedBorder: completeInputBorder,
                    hintText: '123456',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'In case you have given a different number. Enter the OTP received there.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  //width: 200,
                  child: FlatButton(
                    onPressed: () {
                      print('CodeSent' + codeSent.toString());
                      codeSent
                          ? AuthService().signInWithOtp(code.text, otp, context)
                          : verify(number);
                      //Navigator.pop(context);
                    },
                    child: Text(
                      'Verify',
                      style: subhead2.copyWith(
                        fontSize: 14,
                        color: themeColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
      print('Hi  Rapport ${authException.message}');
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
        timeout: Duration(seconds: 30),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}

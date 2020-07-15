import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:teamrapport/login/loginScreen.dart';
import 'package:teamrapport/saveDataLocally/sharedPrefFunctions.dart';


class User {
  User({@required this.number});
  final String number;
}
abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<void> signInWithOtp(String smsCode, String verId, BuildContext context);
  Future<User> signIn(AuthCredential authCredential);
  Future<void> signOut();
}

class Auth implements AuthBase{
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if(user == null){
      return null;
    }
    return User(number: user.phoneNumber);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }
  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }
  @override
  Future<void> signInWithOtp(smsCode, verId, context) async{
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCredential);

  }
  @override
  Future<User> signIn(AuthCredential authCredential) async{
   final authRes = await FirebaseAuth.instance.signInWithCredential(authCredential).catchError((e){print(e);});
   return _userFromFirebase(authRes.user);
  }
  @override
  Future<void> signOut() async{
    SharedPrefFunction().saveUserData(myNumber, []);
    SharedPrefFunction().saveLogoutPreference();
    SharedPrefFunction().saveNumberPreference(' ');
    await FirebaseAuth.instance.signOut();
    
  }
}
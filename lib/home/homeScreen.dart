import 'package:flutter/material.dart';
import 'package:teamrapport/landing_page.dart';
import 'package:teamrapport/services/auth_provider.dart';
import 'package:teamrapport/widgets/platform_alert_dialog.dart';


class HomeScreen extends StatefulWidget {
  static const String homeRoute = '/onboarding/login/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool dataExist = true;

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  void initState() {
    super.initState();
    checkData();
  }
  void checkData() async{

  }
  @override
  Widget build(BuildContext context) {
    Navigator.maybePop(context);
    final auth = AuthProvider.of(context);
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context,snapshot){
        print('Home');
        if(snapshot.hasData){
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: FlatButton.icon(
                  onPressed: () {
                    _confirmSignOut(context);
                  },
                  icon: Icon(Icons.clear),
                  label: Text('Sign Out'),
                ),
              ),
            ),
          );
        }
        else{
        return LandingPage();}
      },
    );
  }
}
//
//Scaffold(
//body: SafeArea(
//child: Container(
//child: FlatButton.icon(
//onPressed: () {
//setState(() {
//AuthService().signOut();
//});
//},
//icon: Icon(Icons.clear),
//label: Text('Sign Out'),
//),
//),
//),
//);
import 'package:flutter/material.dart';
import 'package:teamrapport/landing_page.dart';
import 'package:teamrapport/login/loginScreen.dart';
import 'package:teamrapport/saveDataLocally/sharedPrefFunctions.dart';
import 'package:teamrapport/services/auth_provider.dart';
import 'package:teamrapport/widgets/platform_alert_dialog.dart';


class HomeScreen extends StatefulWidget {
  static const String homeRoute = '/onboarding/login/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool dataExist = true;
  bool isLoading = true;

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
    List myData = await SharedPrefFunction().getStudentData(myNumber);
    print(myData);
    if(myData == null){
      setState(() {
        dataExist = false;
        isLoading =false;
      });
    }
    else{
      setState(() {
        dataExist =true;
        isLoading = false;
        print(myData);
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    final auth = AuthProvider.of(context);
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context,snapshot){
        print('Home');

        if(snapshot.hasData){
          Navigator.maybePop(context);
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
          print(snapshot.connectionState.toString());
        return LandingPage();}
      },
    );
  }
}
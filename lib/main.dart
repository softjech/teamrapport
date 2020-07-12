import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:teamrapport/helpers/customRouteTransition.dart';
import 'package:teamrapport/student/studentInfo.dart';
import 'package:teamrapport/checkUser.dart';
import 'package:teamrapport/saveDataLocally/sharedPrefFunctions.dart';
import 'package:teamrapport/teacher/teacherDetails.dart';
import 'package:teamrapport/widgets/onBoardingScreen.dart';
import 'AuthService.dart';
import 'home/homeScreen.dart';
import 'login/loginScreen.dart';

void main() {
  runApp(MyApp());
}

String isLogin; // I removed = ' ' from here, because I found it unnecessary.

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getDetail();
    super.initState();
  }

  getDetail() async {
    String res = await SharedPrefFunction().getLoginPreference();
    setState(() {
      isLogin = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(
        AssetImage(
          "assets/images/logo_blue.png",
        ),
        context);
    precacheImage(
        AssetImage(
          "assets/images/bg_book_plant.jpg",
        ),
        context);
    precacheImage(
        AssetImage(
          "assets/images/bg_diary.png",
        ),
        context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rapport',
      theme: ThemeData(
        primaryColor: Color(0xFFE3F2FD),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomPageTransitionsBuilder(),
            TargetPlatform.iOS: CustomPageTransitionsBuilder(),
          },
        ),
      ),
//      home: SplashScreen.navigate(
//        name: 'assets/splash.flr',
//        next: (context) {
//          return AuthService().handleAuth();
//        },
//        startAnimation: 'Untitled',
//        until: () => Future.delayed(Duration(seconds: 4)),
//        backgroundColor: Colors.white,
//      ),

      /*This is the routes table. Add all the route names used inside the app here
      Add the route name where the route is made as static const String, so as to you don't need to remember anything.
       */
      routes: {
        //the route name / stands for home / first route in the app.
        '/': (ctx) {
          return SplashScreen.navigate(
            name: 'assets/splash.flr',
            next: (context) {
              return AuthService().handleAuth();
            },
            startAnimation: 'Untitled',
            until: () => Future.delayed(Duration(seconds: 4)),
            backgroundColor: Colors.white,
          );
        },
        LoginScreen.loginRoute: (ctx) => LoginScreen(),
        CheckUser.checkRoute: (ctx) => CheckUser(),
        HomeScreen.homeRoute: (ctx) => HomeScreen(),
        OnboardingScreen.onBoardRoute: (ctx) => OnboardingScreen(),
        StudentInfo.studentRoute: (ctx) => StudentInfo(),
        TeacherDetailsScreen.teacherDetailsRoute: (ctx) =>
            TeacherDetailsScreen(),
      },
    );
  }
}

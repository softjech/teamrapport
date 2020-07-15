import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamrapport/helpers/customRouteTransition.dart';
import 'package:teamrapport/landing_page.dart';
import 'package:teamrapport/services/auth.dart';
import 'package:teamrapport/student/studentInfo.dart';
import 'package:teamrapport/checkUser.dart';
import 'package:teamrapport/saveDataLocally/sharedPrefFunctions.dart';
import 'package:teamrapport/teacher/details_pages/addressDetails.dart';
import 'package:teamrapport/teacher/details_pages/personalDetails.dart';
import 'package:teamrapport/teacher/details_pages/professionalDetails.dart';
import 'package:teamrapport/teacher/teacherHome.dart';
import 'package:teamrapport/teacher/teacherVerification.dart';
import 'package:teamrapport/widgets/onBoardingScreen.dart';
import 'login/loginScreen.dart';
import 'student/student_home_screen.dart';

void main() {

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<Data>(create: (_)=>Data(),),
        Provider<AuthBase>(create: (context)=>Auth(),)
      ],
      child: MyApp(),),);
}

String isLogin=' '; // ' ' it is necessary so that error will not occur because of null value
String teacher = 'false';
List<String> myData = [];
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
    List<String> data=[];
    String res = await SharedPrefFunction().getLoginPreference();
    if(res=='true'){
      String number = await SharedPrefFunction().getNumberPreference();
       data = await SharedPrefFunction().getUserData(number);
       Provider.of<Data>(context,listen: false).changeMyData(data);
    }
    setState(() {
      isLogin = res;
      if(data != null){
        myData = data;
      if(data.length != 0 ){
      if(data[0]=='true'){
        teacher  = 'true';
      }}}
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
              print(isLogin.toString());
              if(isLogin == null){
                return OnboardingScreen();
              }
              else if(isLogin == 'true'){
                if(myData.length == 0){
                  return CheckUser();
                }
                if(teacher=='true'){
                return TeacherHomeScreen();}
                else{
                  return StudentHomeScreen();
                }
              }
              else{
              return LandingPage();}
            },
            startAnimation: 'Untitled',
            until: () => Future.delayed(Duration(seconds: 4)),
            backgroundColor: Colors.white,
          );
        },
        LoginScreen.loginRoute: (ctx) => LoginScreen(),
        CheckUser.checkRoute: (ctx) => CheckUser(),
        OnboardingScreen.onBoardRoute: (ctx) => OnboardingScreen(),
        StudentInfo.studentRoute: (ctx) => StudentInfo(),
        PersonalDetails.routeName:(ctx) => PersonalDetails(),
        ProfessionalDetails.routeName:(ctx) => ProfessionalDetails(),
        AddressDetails.routeName: (ctx) => AddressDetails(),
        TeacherHomeScreen.routeName:(ctx)=>TeacherHomeScreen(),
        TeacherVerification.routeName:(ctx)=>TeacherVerification(),
        StudentHomeScreen.routeName : (ctx)=>StudentHomeScreen(),
      },
    );
  }
}


class Data extends ChangeNotifier{
  List<String> myRealData = [];
  void changeMyData (List<String> value){
    myRealData = value;
    notifyListeners();
  }
}


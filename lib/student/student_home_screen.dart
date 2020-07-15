import 'package:flutter/material.dart';
import 'package:teamrapport/constants.dart';
import 'package:teamrapport/student/tabs/homeTab.dart';


class StudentHomeScreen extends StatefulWidget {
  static const routeName = '/onboarding/login/student/studentHomeScreen';

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHomeScreen> {
  bool _isProfilePicSet = false;
  int _currentTabIndex = 1;
  var _tabs = [
    Center(
      child: Text('Search Tab'),
    ),
    HomeTab(),
    Center(
      child: Text('Profile Tab'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _tabs[_currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
//        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
//        fixedColor: Colors.black,
        iconSize: 24,
        selectedIconTheme: IconThemeData(
          color: themeColor,
          opacity: 1,
        ),
        unselectedIconTheme: IconThemeData(
          color: themeColor,
          opacity: 0.6,
        ),
        showUnselectedLabels: false,
        showSelectedLabels: true,
        elevation: 10,
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'Search',
              style: subhead2.copyWith(color: themeColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Home',
              style: subhead2.copyWith(color: themeColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: _isProfilePicSet
                  ? NetworkImage('set link here')
                  : AssetImage('assets/images/default.png'),
              maxRadius: 12,
            ),
            title: Text(
              'Profile',
              style: subhead2.copyWith(color: themeColor),
            ),
          ),
        ],
      ),
    );
  }
}

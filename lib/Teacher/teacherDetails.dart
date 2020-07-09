import 'package:flutter/material.dart';
import 'package:teamrapport/teacher/teacherData.dart';

class TeacherDetailsScreen extends StatefulWidget {
  static const String teacherDetailsRoute = '/onboarding/lgoin/teacher_details';
  @override
  _TeacherDetailsState createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetailsScreen> {
  PageController _pageController = PageController(initialPage: 0);
  List<SliderModel> _slides = List<SliderModel>();
  int _currentIndex = 0;

  @override
  void initState() {
    _slides = SliderModel().getSlides();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (val) {
          setState(
            () {
              _currentIndex = val;
            },
          );
        },
        itemCount: _slides.length,
        itemBuilder: (context, index) {
          return _slides[index].widget;
        }
      ),
    );
  }
}

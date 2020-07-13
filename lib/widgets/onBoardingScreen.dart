import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamrapport/constants.dart';
import 'package:teamrapport/landing_page.dart';
import 'package:teamrapport/models/data.dart';

class OnboardingScreen extends StatefulWidget {
  static const String onBoardRoute = '/onboarding';

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<SliderModel> slides = new List<SliderModel>();
  PageController pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  Widget pageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  @override
  void initState() {
    slides = SliderModel().getSlides();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: pageController,
        onPageChanged: (val) {
          setState(() {
            _currentIndex = val;
          });
//          print('Index is $_currentIndex');
        },
        itemCount: slides.length,
        itemBuilder: (context, index) {
          return SliderTile(
            imageAssetPath: slides[index].imagePath,
            title: slides[index].title,
            desc: slides[index].desc,
          );
        },
      ),
      bottomSheet: _currentIndex != slides.length - 1
          ? Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      pageController.animateToPage(slides.length - 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear);
                    },
                    child: Text(
                      'SKIP',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      for (int i = 0; i < slides.length - 1; i++)
                        i == _currentIndex
                            ? pageIndexIndicator(true)
                            : pageIndexIndicator(false),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      pageController.animateToPage(_currentIndex + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear);
                    },
                    child: Text(
                      'NEXT',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return LandingPage();
                    },
                  ),
                );
              },
              child: Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                color: themeColor,
                child: Text(
                  'GET STARTED',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
    );
  }
}

class SliderTile extends StatelessWidget {
  final String imageAssetPath, title, desc;

  const SliderTile({Key key, this.imageAssetPath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imageAssetPath,
            width: MediaQuery.of(context).size.width * 0.6,
            fit: BoxFit.fitWidth,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:ala_kosan/helpers/constants.dart';
import 'package:ala_kosan/pages/wrapper.dart';
import 'package:ala_kosan/shared/device.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardScreen extends StatefulWidget {
  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  List<Map<String, String>> _onboardInfo = Constants.onboardInfo;
  PageController _pageController;

  int _indexPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _indexPage);
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _getStarted() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isFirst", false);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Wrapper(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    statusBarBrightness(isDark: true);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: heightOfDevice(context) * 0.8,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _indexPage = value;
                });
              },
              itemCount: _onboardInfo.length,
              itemBuilder: (context, index) => Container(
                color: Colors.white,
                child: LottieBuilder.asset(_onboardInfo[index]["image"]),
              ),
            ),
          ),
          if (_indexPage != _onboardInfo.length - 1)
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    child: Text(
                      "Skip ->",
                      style: buttonText(context)
                          .copyWith(color: primaryColor, fontSize: 16),
                    ),
                    onPressed: () {
                      _pageController.jumpToPage(_onboardInfo.length - 1);
                    },
                  ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              height: heightOfDevice(context) * 0.3,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _onboardInfo[_indexPage]["title"],
                          style: onBoardTitle(context).copyWith(
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          _onboardInfo[_indexPage]["subtitle"],
                          style: onBoardSubtitle(context),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ...List.generate(_onboardInfo.length, (index) {
                          return AnimatedContainer(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            duration: Duration(milliseconds: 300),
                            height: 10,
                            width: index == _indexPage ? 30 : 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: index == _indexPage
                                  ? primaryColor
                                  : Colors.grey,
                            ),
                          );
                        }),
                        Spacer(),
                        if (_indexPage > 0)
                          RoundedIconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: _previousPage),
                        SizedBox(width: 8),
                        _indexPage < _onboardInfo.length - 1
                            ? RoundedIconButton(
                                icon: Icon(Icons.arrow_forward,
                                    color: Colors.white),
                                onPressed: _nextPage,
                              )
                            : ElevatedButton(
                                onPressed: _getStarted,
                                child: Text("Get Started"),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedIconButton extends StatelessWidget {
  final Icon icon;
  final Function onPressed;

  const RoundedIconButton(
      {Key key, @required this.icon, @required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primaryColor,
        ),
        padding: const EdgeInsets.all(8),
        child: InkWell(
          child: icon,
          onTap: onPressed,
        ),
      ),
    );
  }
}

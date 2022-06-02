import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/authenticate.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/logIn/login.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/register/phon_verification_screen.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/onboarding/slider.dart';
import 'package:flutter/material.dart';

import '../../sharedPreferences.dart';
import '../authenticate/first_sign_screen.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  getDateOfUser() async {
    UserApp.userToken = await MySharedPreferences.getUserUserToken() ?? 'null';
    UserApp.userLogIn = await MySharedPreferences.getUserSingIn();
    UserApp.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();
    UserApp.onBoarding = await MySharedPreferences.getOnBoarding();
  }

  @override
  void initState() {
    this.getDateOfUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (UserApp.userLogIn == true) {
      return Authenticate();
    } else {
      if (UserApp.onBoarding == true) {
        return Authenticate();
      }
      return OnBoarding();
    }
  }
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _currentPage = 0;
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      CustomSlider(
        title: "",
        contant: getTranslated(context, 'slider_1')!,
        image: 'lib/images/s1.png',
      ),
      CustomSlider(
        title: "",
        contant: getTranslated(context, 'slider_2')!,
        image: 'lib/images/s2.png',
      ),
      CustomSlider(
        title: "",
        contant: getTranslated(context, 'slider_3')!,
        image: 'lib/images/s3.png',
      ),
    ];
    _onChanged(int index) {
      setState(() {
        _currentPage = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemCount: _pages.length,
              onPageChanged: _onChanged,
              itemBuilder: (context, int index) {
                return _pages[index];
              },
            ),
          ),
          SliderContoler(
            pages: _pages,
            currentPage: _currentPage,
          ),
        ],
      ),
    );
  }
}

class SliderContoler extends StatelessWidget {
  const SliderContoler({
    Key? key,
    required List<Widget> pages,
    required int currentPage,
  })  : _pages = pages,
        _currentPage = currentPage,
        super(key: key);

  final List<Widget> _pages;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
            _pages.length,
            (int index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 10,
                width: (index == _currentPage) ? 30 : 10,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: (index == _currentPage)
                      ? customColorGold
                      : customColorGold.withOpacity(0.5),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  MySharedPreferences.saveUserOnboarding(true);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => FirstSignScreen(),
                    ),
                    (routes) => false,
                  );
                },
                child: Container(
                  height: 35,
                  width: 86,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: customColorGold,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (_currentPage == (_pages.length - 1))
                            ? getTranslated(context, 'start')!
                            : getTranslated(context, 'skip')!,
                        style: AppTheme.heading.copyWith(color: Colors.white),
                      ),
                      (_currentPage == (_pages.length - 1))
                          ? Container()
                          : Transform.rotate(
                              angle: 180 * 3.14 / 180,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

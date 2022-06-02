import 'dart:async';
import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:flutter/material.dart';
import '../sharedPreferences.dart';
import 'onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  static final route = '/splashScreen';

  static bool slider = true;
  static void isSlider() {
    slider = !slider;
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getDateOfUser() async {
    UserApp.userToken = await MySharedPreferences.getUserUserToken() ?? 'null';
    UserApp.userLogIn = await MySharedPreferences.getUserSingIn();
    UserApp.appLang = await MySharedPreferences.getAppLang();
    UserApp.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();
  }

  @override
  void initState() {
    getDateOfUser();
    super.initState();
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => OnBoard(),
          ),
          (routes) => false,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: customColor,
      ),
      body:
          // NetworkSensitive(
          //   child:
          Center(
        child: Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/logo.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
      // ),
    );
  }
}

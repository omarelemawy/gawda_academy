import 'package:elgawda_by_shay_b_haleb_new/secreens/home/home.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/splashscreen.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/wrapper/wrapper.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  Home.route: (_) => Home(),
  SplashScreen.route: (_) => SplashScreen(),
  Wrapper.route: (_) => Wrapper(),
};

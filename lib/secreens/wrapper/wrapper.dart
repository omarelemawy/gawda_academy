import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/cart/cart.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/home/home.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/more/more.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/my%20courses/mycourses.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/wishlist/wishlist.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../sharedPreferences.dart';

// ignore: must_be_immutable
class Wrapper extends StatefulWidget {
  static final route = '/Wrapper';
  int? index;

  Wrapper({Key? key, this.index}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  int _currentIndex = 0;
  getIndex() {
    if (widget.index == null) {
      setState(() {
        _currentIndex = 0;
      });
    } else {
      setState(() {
        _currentIndex = widget.index!;
      });
    }
  }

  final List<Widget> _children = [
    Home(),
    MyCourses(),
    Wishlist(),
    More(),
  ];
  getDateOfUser() async {
    UserApp.userPassword = await MySharedPreferences.getUserUserPassword();
    UserApp.userToken = await MySharedPreferences.getUserUserToken();
    UserApp.appLang = await MySharedPreferences.getAppLang();
    Cart.totalPraices = await MySharedPreferences.getTotalPrice();
    UserApp.userEmail = await MySharedPreferences.getUserUserEmail();
  }

  @override
  void initState() {
    getDateOfUser();
    // gitFCMToken();
    getIndex();
    super.initState();
    print('UserToken:' + UserApp.userToken.toString());
  }

  // gitFCMToken() {
  //   try {
  //     _fcm.getToken().then(
  //       (token) {
  //         print('FCM Token:$token');
  //
  //         updateFcmToken(token);
  //       },
  //     );
  //   } catch (e) {
  //     print('FCM EROOOR');
  //     print(e);
  //   }
  // }

  updateFcmToken(var token) async {
    try {
      var response = await http
          .put(Uri.parse(Utils.Update_fcm_URL.toString() + '$token'), headers: {
        'x-api-key': UserApp.userToken.toString(),
      });
      var jsonData = json.decode(response.body);
      print(jsonData);
    } catch (e) {
      print('Cash updateFcmToken');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color(0xfffF1F1F1),
        selectedItemColor: customColor,
        unselectedItemColor: customColor.withOpacity(.60),
        selectedLabelStyle: AppTheme.headingColorBlue,
        unselectedLabelStyle: AppTheme.subHeadingColorBlue,
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: getTranslated(context, 'home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: getTranslated(context, 'my_courses'),
            icon: Icon(
              FontAwesomeIcons.youtube,
            ),
          ),
          BottomNavigationBarItem(
            label: getTranslated(context, 'wishlist'),
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: getTranslated(context, 'more'),
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}

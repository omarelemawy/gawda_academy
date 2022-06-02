import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:flutter/material.dart';

class Utils {
  static bageColors({String? bage}) {
    Color color;
    switch (bage) {
      case 'bestseller':
        color = Colors.green;
        return color;
        break;
      case 'sale':
        color = Colors.red;
        return color;
        break;
      case 'recent':
        color = customColorGold;
        return color;
        break;
    }
  }

  // ignore: non_constant_identifier_names
  static final BASE_URL = "http://api.jawda-academy.com/api";

  // ignore: non_constant_identifier_names
  static final Update_fcm_URL =
      Uri.parse(BASE_URL + "/clients/update_fcm?fcm_token=");
  // ignore: non_constant_identifier_names
  static final REGISTER_URL = Uri.parse(BASE_URL + "/clients/register");
  // ignore: non_constant_identifier_names
  static final Chat_URL = Uri.parse(BASE_URL + "/chat");
  // ignore: non_constant_identifier_names
  static final Contactus_URL = Uri.parse(BASE_URL + "/mobile_contact");
  // ignore: non_constant_identifier_names
  static final Notifications_URL =
      Uri.parse(BASE_URL + "/clients/notifications");
  // ignore: non_constant_identifier_names
  static final Rate_course_URL = Uri.parse(BASE_URL + "/rate_course");
// ignore: non_constant_identifier_names
  static final Checkout_URL = Uri.parse(BASE_URL + "/orders/checkout");
  // ignore: non_constant_identifier_names
  static final QuizAnssers_URL = Uri.parse(BASE_URL + "/tests");
  // ignore: non_constant_identifier_names
  static final LOGIN_URL = Uri.parse(BASE_URL + "/clients/login");
  // ignore: non_constant_identifier_names
  static final GITUSERDATA_URL = Uri.parse(BASE_URL + "/clients/profile");
  // ignore: non_constant_identifier_names
  static final UPDATEUSERDATA_URL = Uri.parse(BASE_URL + "/clients/update");
  // ignore: non_constant_identifier_names
  static final HOME_URL = Uri.parse(BASE_URL + "/home");
  // ignore: non_constant_identifier_names
  static final Categories_URL = Uri.parse(BASE_URL + "/categories");
  // ignore: non_constant_identifier_names
  static final GOOGLE_URL = Uri.parse(BASE_URL + "/social/google");
  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  static final APPLE_URL = Uri.parse(BASE_URL + "/social/apple");

  // ignore: non_constant_identifier_names
  static final FACEBOOK_URL = Uri.parse(BASE_URL + "/social/facebook");
  // ignore: non_constant_identifier_names
  static final HOMESearch_URL = Uri.parse(BASE_URL + "/search");
  // ignore: non_constant_identifier_names
  static final Instructors_URL = Uri.parse(BASE_URL + "/instructors");
  // ignore: non_constant_identifier_names
  static final MyCourses_URL = Uri.parse(BASE_URL + "/clients/mycourses");
  // ignore: non_constant_identifier_names
  static final MyWishList_URL = Uri.parse(BASE_URL + "/wish_list");
  // ignore: non_constant_identifier_names
  static final SendForgetCode_URL =
      Uri.parse(BASE_URL + "/clients/send_forget_code");
  // ignore: non_constant_identifier_names
  static final CheckForgetCode_URL =
      Uri.parse(BASE_URL + "/clients/check_forget_code");
  // ignore: non_constant_identifier_names
  static final ResetForgetPassword_URL =
      Uri.parse(BASE_URL + "/clients/reset_password_after_forget");
  // ignore: non_constant_identifier_names
  static final AboutUS_URL = Uri.parse(BASE_URL + "/setting/about");
}
